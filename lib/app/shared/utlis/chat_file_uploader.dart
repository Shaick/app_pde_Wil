import 'dart:async';
import 'dart:io';

import 'package:app_pde/app/models/arquivo.dart';
import 'package:app_pde/app/models/upload_callback.dart';
import 'package:app_pde/app/modules/upload_file/utils/firebase_api.dart';
import 'package:app_pde/app/repositories/chat_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatFileUploader {
  final ChatRepository _repository;

  const ChatFileUploader(this._repository);

  UploadCallback upload(Arquivo file, {required String destination}) {
    final task = FirebaseApi.uploadFile(destination, File(file.devicePath!));
    return UploadCallback(file: file, progress: task.snapshotEvents);
  }

  void processUploadedFiles({
    required List<UploadCallback> uploadCallbacks,
    required String chatId,
    required String messageId,
  }) {
    for (int index = 0; index < uploadCallbacks.length; index++) {
      final callback = uploadCallbacks[index];
      late StreamSubscription subscription;
      subscription = callback.progress.listen(
        (progress) async {
          if (progress.state == TaskState.success) {
            final storagePath = progress.ref.fullPath;
            final downloadUrl = await progress.ref.getDownloadURL();
            return _repository.updateAttachmentAfterUpload(
              downloadUrl: downloadUrl,
              storagePath: storagePath,
              fileIndex: index,
              chatId: chatId,
              messageId: messageId,
            );
          }
        },
        onDone: () => subscription.cancel(),
      );
    }
  }
}
