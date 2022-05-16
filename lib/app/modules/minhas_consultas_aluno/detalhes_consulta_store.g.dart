// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalhes_consulta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetalhesConsultaStore on _DetalhesConsultaStoreBase, Store {
  final _$uploadFilesAtom =
      Atom(name: '_DetalhesConsultaStoreBase.uploadFiles');

  @override
  ObservableList<PlatformFile>? get uploadFiles {
    _$uploadFilesAtom.reportRead();
    return super.uploadFiles;
  }

  @override
  set uploadFiles(ObservableList<PlatformFile>? value) {
    _$uploadFilesAtom.reportWrite(value, super.uploadFiles, () {
      super.uploadFiles = value;
    });
  }

  final _$filesAtom = Atom(name: '_DetalhesConsultaStoreBase.files');

  @override
  ArquivoObservableList get files {
    _$filesAtom.reportRead();
    return super.files;
  }

  @override
  set files(ArquivoObservableList value) {
    _$filesAtom.reportWrite(value, super.files, () {
      super.files = value;
    });
  }

  final _$indexFileAtom = Atom(name: '_DetalhesConsultaStoreBase.indexFile');

  @override
  int get indexFile {
    _$indexFileAtom.reportRead();
    return super.indexFile;
  }

  @override
  set indexFile(int value) {
    _$indexFileAtom.reportWrite(value, super.indexFile, () {
      super.indexFile = value;
    });
  }

  final _$orcamentosAtom = Atom(name: '_DetalhesConsultaStoreBase.orcamentos');

  @override
  ObservableList<OrcamentoViewModel> get orcamentos {
    _$orcamentosAtom.reportRead();
    return super.orcamentos;
  }

  @override
  set orcamentos(ObservableList<OrcamentoViewModel> value) {
    _$orcamentosAtom.reportWrite(value, super.orcamentos, () {
      super.orcamentos = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_DetalhesConsultaStoreBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$downloadedFilesPathsAtom =
      Atom(name: '_DetalhesConsultaStoreBase.downloadedFilesPaths');

  @override
  ObservableSet<String> get downloadedFilesPaths {
    _$downloadedFilesPathsAtom.reportRead();
    return super.downloadedFilesPaths;
  }

  @override
  set downloadedFilesPaths(ObservableSet<String> value) {
    _$downloadedFilesPathsAtom.reportWrite(value, super.downloadedFilesPaths,
        () {
      super.downloadedFilesPaths = value;
    });
  }

  final _$setAvaliarConsultaAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.setAvaliarConsulta');

  @override
  Future<void> setAvaliarConsulta(int estrelas) {
    return _$setAvaliarConsultaAsyncAction
        .run(() => super.setAvaliarConsulta(estrelas));
  }

  final _$loadOrcamentosAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.loadOrcamentos');

  @override
  Future<void> loadOrcamentos({required List<Orcamento>? viewOrcamentos}) {
    return _$loadOrcamentosAsyncAction
        .run(() => super.loadOrcamentos(viewOrcamentos: viewOrcamentos));
  }

  final _$loadDownloadedFilesAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.loadDownloadedFiles');

  @override
  Future<void> loadDownloadedFiles({required List<Arquivo> viewFiles}) {
    return _$loadDownloadedFilesAsyncAction
        .run(() => super.loadDownloadedFiles(viewFiles: viewFiles));
  }

  final _$deleteFileAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.deleteFile');

  @override
  Future<void> deleteFile(ArquivoViewModel file) {
    return _$deleteFileAsyncAction.run(() => super.deleteFile(file));
  }

  final _$requestDownloadAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.requestDownload');

  @override
  Future<void> requestDownload(ArquivoViewModel file) {
    return _$requestDownloadAsyncAction.run(() => super.requestDownload(file));
  }

  final _$selectMultFilesAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.selectMultFiles');

  @override
  Future<dynamic> selectMultFiles() {
    return _$selectMultFilesAsyncAction.run(() => super.selectMultFiles());
  }

  final _$uploadArquivoApoioAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.uploadArquivoApoio');

  @override
  Future<dynamic> uploadArquivoApoio(
      ConsultaViewModel consulta, SituacaoConsulta situacao) {
    return _$uploadArquivoApoioAsyncAction
        .run(() => super.uploadArquivoApoio(consulta, situacao));
  }

  final _$alunoEscolheOrcamentoAsyncAction =
      AsyncAction('_DetalhesConsultaStoreBase.alunoEscolheOrcamento');

  @override
  Future<dynamic> alunoEscolheOrcamento(dynamic idOrcamento) {
    return _$alunoEscolheOrcamentoAsyncAction
        .run(() => super.alunoEscolheOrcamento(idOrcamento));
  }

  final _$_DetalhesConsultaStoreBaseActionController =
      ActionController(name: '_DetalhesConsultaStoreBase');

  @override
  ArquivoViewModel getFiles(
      {required Arquivo file,
      required ObservableSet<String> downloadedFilesPaths}) {
    final _$actionInfo = _$_DetalhesConsultaStoreBaseActionController
        .startAction(name: '_DetalhesConsultaStoreBase.getFiles');
    try {
      return super
          .getFiles(file: file, downloadedFilesPaths: downloadedFilesPaths);
    } finally {
      _$_DetalhesConsultaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void downloadAll(List<ArquivoViewModel> list) {
    final _$actionInfo = _$_DetalhesConsultaStoreBaseActionController
        .startAction(name: '_DetalhesConsultaStoreBase.downloadAll');
    try {
      return super.downloadAll(list);
    } finally {
      _$_DetalhesConsultaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uploadFiles: ${uploadFiles},
files: ${files},
indexFile: ${indexFile},
orcamentos: ${orcamentos},
formKey: ${formKey},
downloadedFilesPaths: ${downloadedFilesPaths}
    ''';
  }
}
