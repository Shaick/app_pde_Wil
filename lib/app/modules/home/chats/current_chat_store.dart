import 'dart:async';
import 'dart:io';
import 'package:app_pde/app/models/bad_message.dart';
import 'package:app_pde/app/models/filtered_message.dart';
import 'package:app_pde/app/models/mensagem.dart';
import 'package:app_pde/app/models/upload_callback.dart';
import 'package:app_pde/app/modules/home/chats/all_chats_store.dart';
import 'package:app_pde/app/modules/home/chats/view_models/chat_view_model.dart';
import 'package:app_pde/app/modules/home/chats/view_models/mensagem_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/repositories/chat_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/utlis/bad_message_filter.dart';
import 'package:app_pde/app/shared/utlis/chat_file_uploader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:ntp/ntp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:android_path_provider/android_path_provider.dart';

part 'current_chat_store.g.dart';

class CurrentChatStore = _CurrentChatStoreBase with _$CurrentChatStore;

abstract class _CurrentChatStoreBase extends BaseStore with Store {
  final ChatRepository _repository;
  final AuthController _authController;
  final ChatFileUploader _fileUploader;
  final AllChatsStore _allChatsStore;

  _CurrentChatStoreBase(
    this._repository,
    this._authController,
    this._fileUploader,
    this._allChatsStore,
  );

  void initialize(ChatViewModel chat) {
    assignCurrentChat(chat);
    watchChatMessages();
  }

  // MENSAGENS

  final messageController = TextEditingController();

  late final ChatViewModel currentChat;

  @observable
  ObservableStream<List<MensagemViewModel>>? onNewMessage;

  void assignCurrentChat(ChatViewModel chat) => currentChat = chat;

  void watchChatMessages() {
    final downloadedFiles = _allChatsStore.downloadedFilesPaths;
    onNewMessage =
        ObservableStream(_repository.watchChatMessages(currentChat.id).map(
      (messages) {
        messages.sort(((a, b) => (a.timestamp.microsecondsSinceEpoch >
                b.timestamp.microsecondsSinceEpoch
            ? -1
            : 1)));
        return messages.map((e) {
          final message = MensagemViewModel.fromDomain(e);
          if (!message.temArquivos || downloadedFiles.isEmpty) return message;

          final newArquivos = message.arquivos?.map((file) {
            try {
              if (downloadedFiles
                  .any((filePath) => filePath.endsWith(file.fileName))) {
                final path = downloadedFiles.firstWhere(
                  (filePath) => filePath.endsWith(file.fileName),
                );
                return file.copyWith(devicePath: path);
              } else
                return file;
            } on StateError catch (_) {
              return file;
            }
          }).toList();
          return message.copyWith(arquivos: newArquivos);
        }).toList();
      },
    ));
  }

  Future<void> sendMessage() async {
    DateTime dateTime = await NTP.now();
    if (messageController.text.isEmpty && pickedFiles.isEmpty) return;
    final senderId = _authController.user!.id;
    final filteredMessage =
        BadMessageFilter.filter(messageController.text, dateTime);
    final uploadCallbacks = _processPickedFiles();
    final message = Mensagem(
      id: '',
      idRemetente: senderId,
      texto: filteredMessage.text,
      visto: false,
      timestamp: dateTime,
      arquivos: uploadCallbacks?.map((e) => e.file).toList(),
    );
    messageController.clear();
    pickedFiles.clear();
    final messageId =
        await _repository.addMessage(message, chatId: currentChat.id);

    if (uploadCallbacks != null) {
      _fileUploader.processUploadedFiles(
        uploadCallbacks: uploadCallbacks,
        chatId: currentChat.id,
        messageId: messageId!,
      );
      _allChatsStore.getDownloadedFiles().then((_) => watchChatMessages());
    }

    if (filteredMessage.isBad) {
      return _handleBadMessages(
        filteredMessage,
        senderId: senderId,
        messageId: messageId!,
      );
    }

    return;
  }

  Future<void> _handleBadMessages(
    FilteredMessage message, {
    required String senderId,
    required String messageId,
  }) async {
    final badMessage = BadMessage.fromFilteredMessage(
      filteredMessage: message,
      senderId: senderId,
      messageId: messageId,
      chat: currentChat,
    );
    return makeAsyncRequest(() => _repository.addBadMessage(badMessage));
  }

  Future<void> markMessagesAsRead() async {
    if (currentChat.mensagens.any((message) => !message.visto)) {
      return _repository.markMessagesAsRead(
        chatId: currentChat.id,
        messagesIds: currentChat.mensagens.map((e) => e.id).toList(),
      );
    }
  }

  // ARQUIVOS

  @observable
  ObservableList<ArquivoViewModel> pickedFiles = ObservableList();

  @observable
  ObservableSet<String> downloadedFilesPaths = ObservableSet();

  Future<void> takePicture() async {
    final picker = ImagePicker();
    XFile? _image;

    //Check Permissions
    await Permission.photos.request();

    try {
      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        _image = await picker.pickImage(source: ImageSource.camera);

        if (_image != null) {
          final date = await NTP.now();
          var files = ArquivoViewModel(
            displayName: _image.name,
            fileName: date.millisecondsSinceEpoch.toString() +
                '.' +
                _image.name.split('.').last,
            devicePath: _image.path,
          );
          pickedFiles.add(files);
        }
      }
    } on PlatformException catch (e) {
      print(e.code);
    }
  }

  @action
  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile e = result.files.first;
      final date = await NTP.now();
      final file = ArquivoViewModel(
        fileName: date.millisecondsSinceEpoch.toString() +
            '.' +
            e.name.split('.').last,
        displayName: e.name,
        devicePath: e.path,
      );
      pickedFiles.add(file);
    }
  }

  @action
  Future<void> getDownloadedFilesPaths() async {
    List<String> files = [];
    Directory? dir;
    if (Platform.isAndroid) {
      var d = await AndroidPathProvider.downloadsPath;
      dir = Directory(d);
    } else {
      dir = await path.getExternalStorageDirectory();
      if (dir != null) {
        files.addAll(dir.listSync(recursive: true).map((e) => e.path).toList());
      }
    }

    final temp = await path.getTemporaryDirectory();

    files.addAll(dir!.listSync(recursive: true).map((e) => e.path).toList());

    files.addAll(temp.listSync(recursive: true).map((e) => e.path).toList());

    downloadedFilesPaths.addAll(files);
    return downloadedFilesPaths.addAll(files);
  }

  @action
  void removeFile(ArquivoViewModel file) {
    pickedFiles.remove(file);
  }

  List<UploadCallback>? _processPickedFiles() {
    if (pickedFiles.isEmpty) return null;
    List<UploadCallback> uploadCallbacks = [];
    toggleAttachmentCard();

    final files = pickedFiles.map((viewModel) => viewModel.toDomain()).toList();
    files.forEach((file) {
      final destination = 'chats/${currentChat.id}/${file.nome}';
      uploadCallbacks.add(_fileUploader.upload(file, destination: destination));
    });
    return uploadCallbacks.isEmpty ? null : uploadCallbacks;
  }

  // ANIMAÇÕES

  late AnimationController _controller;
  Animation<double> get animation => _controller.drive(
        CurveTween(curve: Curves.easeOut),
      );

  void toggleAttachmentCard({bool chatPage = false}) {
    if (chatPage)
      _controller.isCompleted ? _controller.reverse() : null;
    else
      _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }

  void registerAnimationController(AnimationController controller) {
    _controller = controller;
  }

  void disposeController() {
    _controller.dispose();
  }

  void dismissKeyboard(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }
}
