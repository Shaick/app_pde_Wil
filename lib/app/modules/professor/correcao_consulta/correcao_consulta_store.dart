import 'dart:async';
import 'dart:io';

import 'package:app_pde/app/models/arquivo.dart';
import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/dtos/arquivo_dto.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/custom_alert_dialog.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_observable_list.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/correcao_view_model.dart';
import 'package:app_pde/app/modules/upload_file/upload_file_store.dart';
import 'package:app_pde/app/modules/upload_file/utils/firebase_api.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:app_pde/app/shared/utlis/download_service.dart';
import 'package:app_pde/app/shared/utlis/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'correcao_consulta_store.g.dart';

class CorrecaoConsultaStore = _CorrecaoConsultaStoreBase
    with _$CorrecaoConsultaStore;

abstract class _CorrecaoConsultaStoreBase extends BaseStore with Store {
  final DownloadService _downloadService;
  final FirebaseRepository _repository;
  final UploadFileStore uploadFileStore;

  _CorrecaoConsultaStoreBase(
      this._downloadService, this._repository, this.uploadFileStore);

  final replyController = TextEditingController();

  String? validaReply(String texto) => Validators.validarReply(texto);

  @observable
  ObservableList<PlatformFile>? uploadFiles = <PlatformFile>[].asObservable();

  @observable
  ObservableList<CorrecaoViewModel> listCorrecao =
      <CorrecaoViewModel>[].asObservable();

  UploadTask? task;
  String url = '';
  var destination;
  var situacao;

  @observable
  String idNumber = '';

  @observable
  String id = '';

  @observable
  SituacaoConsulta situacaoConsulta = SituacaoConsulta.finalizada;

  @observable
  bool newReply = false;

  @observable
  bool? erroProfessor = false;

  @observable
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  void popPage() => Modular.to.pop();

  @action
  void habiliteSubmit() => newReply = !newReply;

  _navigateToMain(bool isAluno) => Future.delayed(const Duration(seconds: 1),
      () => Modular.to.pushReplacementNamed(isAluno ? '/home' : '/professor'));

  @action
  init(ConsultaViewModel consulta) async {
    id = consulta.id;
    idNumber = consulta.idNumerico;
    erroProfessor = consulta.erroProfessor;
    situacaoConsulta = consulta.situacao;
    CorrecaoViewModel item;

    item = consulta.reclamacao();
    item.filesArquivos.addAll(
        await loadDownloadedFiles(viewFiles: consulta.arquivosCorrecao!));
    if (item.verMessagem)
      listCorrecao.add(item);
    else if (item.options) {
      habiliteSubmit();
      listCorrecao.add(
          consulta.newItem().copyWith(tipoCorrecao: TipoCorrecao.reclamacao));
    }

    item = consulta.replica();
    item.filesArquivos.addAll(
        await loadDownloadedFiles(viewFiles: consulta.arquivosReplica!));
    if (item.verMessagem)
      listCorrecao.add(item);
    else if (item.options)
      listCorrecao
          .add(consulta.newItem().copyWith(tipoCorrecao: TipoCorrecao.replica));

    item = consulta.treplica();
    item.filesArquivos.addAll(
        await loadDownloadedFiles(viewFiles: consulta.arquivosTreplica!));
    if (item.verMessagem)
      listCorrecao.add(item);
    else if (item.options)
      listCorrecao.add(
          consulta.newItem().copyWith(tipoCorrecao: TipoCorrecao.treplica));

    item = consulta.finalProfessor();
    item.filesArquivos.addAll(await loadDownloadedFiles(
        viewFiles: consulta.arquivosRFinalProfessor!));
    if (item.verMessagem)
      listCorrecao.add(item);
    else if (item.options)
      listCorrecao.add(consulta
          .newItem()
          .copyWith(tipoCorrecao: TipoCorrecao.finalprofessor));

    item = consulta.finalAluno();
    item.filesArquivos.addAll(
        await loadDownloadedFiles(viewFiles: consulta.arquivosRFinalAluno!));
    if (item.verMessagem)
      listCorrecao.add(item);
    else if (item.options)
      listCorrecao.add(
          consulta.newItem().copyWith(tipoCorrecao: TipoCorrecao.finalaluno));
  }

  String textError(bool isAluno) {
    if (erroProfessor != null) {
      return isAluno
          ? erroProfessor!
              ? 'O professor já assumiu o erro, entre em contato com o atendimento.'
              : 'Você já deu o parecer sobre esse problema, logo a central irá concluir a atividade e ela estará em Finalizadas.'
          : erroProfessor!
              ? 'Você já deu o parecer sobre esse problema, logo a central irá concluir a consulta e ela estará em Finalizadas com o devido problema sinalizado.'
              : 'O aluno já percebeu que sua correção está correta, logo a consulta irá ser concluída. Agradecemos pela parceria!';
    } else
      return '';
  }

  List<String> text(TipoCorrecao type, bool isAluno) {
    switch (type) {
      case TipoCorrecao.reclamacao:
        return isAluno
            ? ['Sua Pedido', '', '', 'Diga-nos, do que precisa?']
            : ['Reclamação', '', '', ''];
      case TipoCorrecao.replica:
        return isAluno
            ? ['Resposta do Professor', '', '', '']
            : [
                'Sua Resposta',
                'Aceitar Erro',
                'Responder',
                'Qula o seu parecer sobre o erro?'
              ];
      case TipoCorrecao.treplica:
        return isAluno
            ? [
                'Sua Reposta',
                'Aceitar Correção',
                'Responder',
                'Diga-nos o que está faltando?'
              ]
            : ['Resposta do Aluno', '', '', ''];
      case TipoCorrecao.finalprofessor:
        return isAluno
            ? ['Resposta do Professor', '', '', '']
            : [
                'Sua Resposta',
                'Aceitar Erro',
                'Responder',
                'Apresente o seu parecer final'
              ];
      case TipoCorrecao.finalaluno:
        return isAluno
            ? [
                'Sua Resposta',
                'Aceitar Correção',
                'Responder',
                'Retrate o seu parecer final?'
              ]
            : ['Resposta do Aluno', '', '', ''];
    }
  }

  Future<void> sendQueryCorrection(
      BuildContext context, CorrecaoViewModel correcao) async {
    if (uploadFileStore.uploadFiles.isEmpty) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const CustomAlertDialog(
          title: 'Upload de arquivos obrigatórios',
          message: 'Por favor, adicione arquivos de apoio.',
        ),
      );
    } else if (uploadFileStore.badFiles.isNotEmpty) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const CustomAlertDialog(
          title: 'Erro no upload dos arquivos',
          message:
              'Algum arquivo está com uma extensão que não é aceita. Tente um arquivo diferente.',
        ),
      );
    } else {
      if (formKey.currentState!.validate()) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => const AlertDialog(
                  title: const Text(
                    'Realizando pedido de Correcao',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Aguarde enquanto o processo termina',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ));
        queryConsulta(correcao).then((value) {
          _navigateToMain(correcao.isAluno);
        });
      }
      ;
    }
  }

  @action
  Future<void> queryConsulta(CorrecaoViewModel correcao) async {
    try {
      var pathArq = '';
      var pathSubmit = '';
      var pathGet = 'ativas';

      switch (correcao.tipoCorrecao) {
        case TipoCorrecao.reclamacao:
          pathGet = correcao.situacaoConsulta == SituacaoConsulta.andamento
              ? 'ativas'
              : 'concluidas';
          pathSubmit = 'TextCorrecao';
          pathArq = 'consultas/ativas/${id}/ArquivosCorrecao';
          break;
        case TipoCorrecao.replica:
          pathSubmit = 'TextReplica';
          pathArq = 'consultas/ativas/${id}/ArquivosReplica';
          break;
        case TipoCorrecao.treplica:
          pathSubmit = 'TextTreplica';
          pathArq = 'consultas/ativas/${id}/ArquivosTreplica';
          break;
        case TipoCorrecao.finalprofessor:
          pathSubmit = 'TextRFinalProfessor';
          pathArq = 'consultas/ativas/${id}/ArquivosRFinalProfessor';
          break;
        case TipoCorrecao.finalaluno:
          pathSubmit = 'TextRFinalAluno';
          pathArq = 'consultas/ativas/${id}/ArquivosRFinalAluno';
          break;
      }

      var _db = _repository.db;

      final queryConsulta = _db.child('consultas').child('ativas').child(id);

      final json = await getConsultaId(pathGet);

      json[pathSubmit] = replyController.text;

      final TransactionResult transactionInsert =
          await queryConsulta.runTransaction((consulta) {
        consulta = json;
        return Transaction.success(consulta);
      });

      if (transactionInsert.committed) {
        final consultaReference = _db.child(pathArq);
        uploadFileStore.uploadFiles.forEach(
            (file) async => await _processFileUpload(file, consultaReference));

        if (pathGet == 'concluidas') {
          DatabaseReference databaseReference =
              _db.child('consultas').child('concluidas').child(id);
          await databaseReference.remove().then((value) => print('removido!'));
        }
      }
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  Future<void> _processFileUpload(
    ArquivoViewModel file,
    DatabaseReference reference,
  ) async {
    var fileDTO = _buildFileDTO(file: file, consultaReference: reference);
    final downloadUrl = await uploadFileStore.uploadSingleFile(
      fileDTO,
      devicePath: file.devicePath!,
    );
    fileDTO = fileDTO.copyWith(downloadUrl: downloadUrl);
    return reference.push().set(fileDTO.toJson());
  }

  ArquivoDTO _buildFileDTO({
    required ArquivoViewModel file,
    required DatabaseReference consultaReference,
  }) {
    final now = DateTime.now();
    final storageFileName = '${now.toIso8601String()}--${file.fileName}';
    final idConsulta = consultaReference.key;
    final storagePath = consultaReference.parent!.parent!
        .child(idConsulta ?? 'SemID')
        .child(storageFileName);
    return ArquivoDTO(
      nome: file.fileName,
      downloadUrl: '',
      storagePath: storagePath.path,
      timestamp: now.millisecondsSinceEpoch,
      fileExtension: file.fileExtension,
      size: file.size,
    );
  }

  @action
  Future<Map<dynamic, dynamic>> getConsultaId(String path) async {
    final dbEvent =
        await _repository.db.child('consultas').child(path).child(id).once();
    return Map<dynamic, dynamic>.from(dbEvent.snapshot.value as Map);
  }

  @action
  Future<void> registreError(context, TipoCorrecao tipo, bool isAluno) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                isAluno
                    ? 'Aceitado correção do professor'
                    : 'Confirmando error na consulta',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Aguarde enquanto o processo termina',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ));
    try {
      final erroProfessor = ((tipo == TipoCorrecao.replica) ||
              (tipo == TipoCorrecao.finalprofessor))
          ? true
          : false;

      var _db = _repository.db;

      final queryConsulta = _db.child('consultas').child('ativas').child(id);

      final TransactionResult transactionInsert =
          await queryConsulta.runTransaction((consulta) {
        if (consulta != null) {
          Map<String, dynamic> _consulta =
              Map<String, dynamic>.from(consulta as Map);
          _consulta['ErroProfessor'] = erroProfessor;
          return Transaction.success(_consulta);
        } else {
          return Transaction.abort();
        }
      });
      if (transactionInsert.committed) _navigateToMain(isAluno);
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  @action
  Future<void> backConsulta() async {
    try {
      var _db = _repository.db;

      final queryConsulta =
          _db.child('consultas').child('concluidas').child(id);

      DatabaseReference databaseReference =
          _db.child('consultas').child('ativas').child(id);

      final json = await getConsultaId('ativas');

      json['TextCorrecao'] = '';

      final TransactionResult transactionInsert =
          await queryConsulta.runTransaction((consulta) {
        consulta = json;
        return Transaction.success(consulta);
      });
      if (transactionInsert.committed) {
        await databaseReference.remove().then((value) => print('removido!'));
      }
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  @action
  Future<ArquivoObservableList> loadDownloadedFiles(
      {required List<Arquivo> viewFiles}) async {
    final tasks = await FlutterDownloader.loadTasks();
    final list = ArquivoObservableList();
    viewFiles.forEach((file) {
      final fileName = '${file.timestamp.millisecondsSinceEpoch}_${file.nome}';
      final index = tasks!.indexWhere((task) => task.url == file.downloadUrl);
      if (index.isNegative) {
        list.add(ArquivoViewModel(
          id: file.id,
          fileName: fileName,
          downloadUrl: file.downloadUrl,
          displayName: file.nome,
        ));
      } else {
        list.add(ArquivoViewModel.withTask(
          id: file.id!,
          displayName: file.nome,
          fileName: fileName,
          downloadUrl: file.downloadUrl!,
          task: tasks[index],
        ));
      }
    });
    return list;
  }

  @action
  Future<void> deleteFile(
      ArquivoObservableList list, ArquivoViewModel file) async {
    list.remove(file);
    /* _repository
        .deleteFileInsideConsulta(
      idArquivo: file.id!,
      idConsulta: id,
      situacao: situacaoConsulta,
    )
        .then((_) => _professorStore.getConsultasProfessor());*/
    if (file.taskId != null) {
      return FlutterDownloader.remove(
        taskId: file.taskId!,
        shouldDeleteContent: true,
      );
    }
  }

  Future<void> openFile(ArquivoViewModel file) {
    return FlutterDownloader.open(taskId: file.taskId!);
  }

  Future<void> retryDownload(
      ArquivoObservableList list, ArquivoViewModel file) async {
    final newTaskId = await FlutterDownloader.retry(taskId: file.taskId!);
    list.changeFileTaskId(file: file, newTaskId: newTaskId!);
  }

  @action
  Future<void> requestDownload(
      ArquivoObservableList list, ArquivoViewModel file) async {
    late StreamSubscription subscription;
    final fileIndex = list.indexOf(file);
    subscription = _downloadService.downloadProgress.listen((feedback) {
      list.changeFileStatus(index: fileIndex, newStatus: feedback.status);
      if (feedback.status == DownloadTaskStatus.complete) {
        list.changeFileTaskId(index: fileIndex, newTaskId: feedback.taskId);
        subscription.cancel();
      }
    });
    return makeAsyncRequest(() => _downloadService.download(
          downloadUrl: file.downloadUrl!,
          fileName: file.fileName,
        ));
  }

  @action
  Future selectMultFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      uploadFiles!.clear();
      List<PlatformFile> files = result.files;
      files.forEach((e) {
        uploadFiles?.add(e);
      });
    }
  }

  Future uploadStorageFile(ConsultaViewModel consulta) async {
    uploadFiles?.forEach((e) {
      var idArquivo = DateTime.now().toIso8601String() + '--' + e.name;
      destination = '$situacao/${consulta.id}/$idArquivo';
      task = FirebaseApi.uploadFile(destination, File('${e.path}'));
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    url = '$urlDownload';
  }

  uploadArquivoApoio(ConsultaViewModel consulta, SituacaoConsulta situacao) {
    String? result;
    var _db = _repository.db;

    if (situacao == SituacaoConsulta.pendente) {
      result = 'liberar';
    }
    if (situacao == SituacaoConsulta.andamento) {
      result = 'ativas';
    }

    var refLiberarArquivo =
        _db.child('consultas/$result/${consulta.id}/ArquivosApoio');

    setFiles(PlatformFile e) {
      return {
        'Nome': e.name,
        'Tamanho': e.size,
        'Tipo': e.extension,
        'Url': url,
        'Data': DateTime.now().millisecondsSinceEpoch,
        'FullPath':
            '${result}/${consulta.id}/${DateTime.now().toIso8601String() + '--' + e.name}',
      };
    }

    if (uploadFiles!.isNotEmpty) {
      uploadStorageFile(consulta).then((_) => uploadFiles!.forEach((file) {
            refLiberarArquivo
                .push()
                .set(setFiles(file))
                .then((value) => uploadFiles!.clear());
          }));
    }
  }

  void dispose() {
    _downloadService.dispose();
  }
}
