// ignore_for_file: unnecessary_import

import 'dart:async';
import 'dart:io';

import 'package:app_pde/app/models/arquivo.dart';
import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_observable_list.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/professor_store.dart';
import 'package:app_pde/app/modules/upload_file/utils/firebase_api.dart';
import 'package:app_pde/app/repositories/professor_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:app_pde/app/shared/utlis/device_utils.dart';
import 'package:app_pde/app/shared/utlis/download_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'detalhes_consulta_professor_store.g.dart';

class DetalhesConsultaProfessorStore = _DetalhesConsultaProfessorStoreBase
    with _$DetalhesConsultaProfessorStore;

abstract class _DetalhesConsultaProfessorStoreBase extends BaseStore
    with Store {
  final DownloadService _downloadService;
  final ProfessorRepository _repository;
  final ProfessorStore _professorStore;
  final AuthController _authController;
  final ctrlValorProfessor = TextEditingController();
  final FirebaseAuth _firebaseAuth;
  @action
  String? validaValor(String texto) {
    if (texto.isEmpty) {
      return "Por favor insira uma valor";
    }
    return null;
  }

  _DetalhesConsultaProfessorStoreBase(this._downloadService, this._repository,
      this._professorStore, this._authController, this._firebaseAuth);

  @observable
  int indexFile = 0;

  late ConsultaViewModel consulta;

  @observable
  ObservableList<PlatformFile>? uploadFiles = <PlatformFile>[].asObservable();

  UploadTask? task;
  String url = '';
  var destination;
  var situacao;

  @observable
  ArquivoObservableList files = ArquivoObservableList();

  @observable
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @observable
  ObservableSet<String> downloadedFilesPaths = ObservableSet();

  @observable
  bool isPendente = false;

  void popPage() {
    Modular.to.pushReplacementNamed('/professor');
  }

  String? getValorOrcamentoProfessorLogado() {
    var idProf = _authController.user?.id;
    try {
      if (idProf != null) {
        var orcamentos = consulta.orcamentos;
        if (orcamentos != null && orcamentos.length > 0) {
          var orcamento =
              orcamentos.firstWhere((orc) => orc.idProfessor == idProf);
          if (orcamento.valorConsulta != null) {
            return NumberFormat.currency(symbol: 'R\$')
                .format(orcamento.valorConsulta);
          }
        }
      }
    } catch (e) {}
    return null;
  }

  Future<void> pushCorrecaoConsultaPage(ConsultaViewModel consulta) {
    return Modular.to.pushNamed(
        '/professor/consultas/${consulta.idNumerico}/correcao',
        arguments: consulta);
  }

  @action
  Future<void> setProfessorConsulta(context, ConsultaViewModel consulta) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: const Text(
          'Processando o agendando da conusulta',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Aguarde enquanto o processo termina',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
    makeAsyncRequest(() {
      return Future.value(_repository.setProfessorConsulta(consulta.id));
    }).then((results) async {
      if (results == null) return;
      await _professorStore.getConsultasProfessor();
      popPage();
    });
  }

  @action
  void getIdPermission() {
    final user = _authController.user!;
    if (user.idPermissao == "4") {
      isPendente = true;
    }
  }

  @action
  Future<void> setBanirProfessor(context, ConsultaViewModel consulta) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => const AlertDialog(
              title: const Text(
                'Ativando não visualização',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Aguarde enquanto o processo termina',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ));
    makeAsyncRequest(() {
      return Future.value(_repository.setBanirProfessor(consulta.id));
    }).then((results) async {
      if (results == null) return;
      await _professorStore.getConsultasProfessor();
      popPage();
    });
  }

  @action
  ArquivoViewModel getFiles(
      {required Arquivo file,
      required ObservableSet<String> downloadedFilesPaths}) {
    try {
      if (downloadedFilesPaths
          .any((filePath) => filePath.endsWith(file.nome))) {
        final path = downloadedFilesPaths.firstWhere(
          (filePath) => filePath.endsWith(file.nome),
        );

        return ArquivoViewModel(
            id: file.id,
            displayName: file.nome,
            fileName: file.nome,
            devicePath: path,
            downloadUrl: file.downloadUrl);
      } else {
        return ArquivoViewModel(
            id: file.id,
            displayName: file.nome,
            fileName: file.nome,
            downloadUrl: file.downloadUrl);
      }
    } on StateError catch (_) {
      return ArquivoViewModel(
          id: file.id,
          displayName: file.nome,
          fileName: file.nome,
          downloadUrl: file.downloadUrl);
    }
  }

  @action
  Future<void> loadDownloadedFiles({required List<Arquivo> viewFiles}) async {
    await DeviceUtils().getDownloadedFilesPaths().then((value) {
      if (value != null) {
        downloadedFilesPaths.addAll(value);
      }
    });
    final tasks = await FlutterDownloader.loadTasks();

    files.clear();
    viewFiles.forEach((file) async {
      final fileName = '${file.timestamp.millisecondsSinceEpoch}_${file.nome}';
      final index = tasks!.indexWhere((task) => task.url == file.downloadUrl);
      if (index.isNegative) {
        files.add(
            getFiles(file: file, downloadedFilesPaths: downloadedFilesPaths));
      } else {
        files.add(ArquivoViewModel.withTask(
          id: file.id!,
          displayName: file.nome,
          fileName: fileName,
          downloadUrl: file.downloadUrl!,
          task: tasks[index],
        ));
      }
    });
  }

  @action
  Future<void> deleteFile(ArquivoViewModel file) async {
    files.remove(file);
    _repository
        .deleteFileInsideConsulta(
          idArquivo: file.id!,
          idConsulta: consulta.id,
          situacao: consulta.situacao,
        )
        .then((_) => _professorStore.getConsultasProfessor());
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

  Future<void> retryDownload(ArquivoViewModel file) async {
    try {
      final newTaskId = await FlutterDownloader.retry(taskId: file.taskId!);
      files.changeFileTaskId(file: file, newTaskId: newTaskId!);
    } catch (e) {
      print("retry: " + e.toString());
      await requestDownload(file);
    }
  }

  @action
  Future<void> requestDownload(ArquivoViewModel file) async {
    //files.changeFileStatus(file: file, newStatus: DownloadTaskStatus.running);
    await makeAsyncRequest(() async {
      String? taskId = await _downloadService.download(
        downloadUrl: file.downloadUrl!,
        fileName: file.fileName,
      );
      int index = files.indexOf(file);
      if (taskId != null) {
        files.changeFileStatus(
            index: index, newStatus: DownloadTaskStatus.complete);
        files.changeFileTaskId(index: index, newTaskId: taskId);
      } else {
        files.changeFileStatus(
            index: index, newStatus: DownloadTaskStatus.failed);
      }
    });
  }

  @action
  void downloadAll(List<ArquivoViewModel> list) {
    list.forEach((element) {
      if (element.status == DownloadTaskStatus.failed) {
        retryDownload(element);
      } else if (element.status == DownloadTaskStatus.undefined) {
        requestDownload(element);
      }
    });
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

/*  Future<void> pushOrcamentoPage(ConsultaViewModel consulta) {
    return Modular.to.pushNamed(
        '/professor/consultas/${consulta.idNumerico}/orcamento',
        arguments: consulta);
  }*/

  @action
  Future<void> saveOrcamento() {
    var _db = _repository.db;
    var orcamento;
    try {
      orcamento = setOrcamento();
    } catch (e) {
      throw Failure(e.toString());
    }
    final pathOrcamento = _db
        .child('consultas')
        .child('ativas')
        .child('${consulta.id}')
        .child('Orcamentos')
        .child(_firebaseAuth.currentUser!.uid);

    return makeAsyncRequest(() async {
      await pathOrcamento.set(orcamento);
      Future.delayed(const Duration(seconds: 5)).then((results) async {
        await _professorStore.getConsultasProfessor();
        popPage();
      });
    });
  }

  setOrcamento() {
    var valorAtividade;
    if (ctrlValorProfessor.text.isNotEmpty &&
        ctrlValorProfessor.text.length >= 4) {
      valorAtividade = ctrlValorProfessor.text
          .replaceAll('R\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .trim();
    } else if (ctrlValorProfessor.text.isNotEmpty) {
      valorAtividade = ctrlValorProfessor.text
          .replaceAll('R\$', '')
          .replaceAll(',', '.')
          .trim();
    }

    return {
      'IDProfessor': _firebaseAuth.currentUser!.uid,
      'ValorProfessor':
          valorAtividade != null ? double.parse(valorAtividade) : 0,
      'NomeFantasia': '',
      'AlunoJaViuOrcamento': false,
      'Escolhido': false
    };
  }
}
