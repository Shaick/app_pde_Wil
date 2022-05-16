// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correcao_consulta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CorrecaoConsultaStore on _CorrecaoConsultaStoreBase, Store {
  final _$uploadFilesAtom =
      Atom(name: '_CorrecaoConsultaStoreBase.uploadFiles');

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

  final _$listCorrecaoAtom =
      Atom(name: '_CorrecaoConsultaStoreBase.listCorrecao');

  @override
  ObservableList<CorrecaoViewModel> get listCorrecao {
    _$listCorrecaoAtom.reportRead();
    return super.listCorrecao;
  }

  @override
  set listCorrecao(ObservableList<CorrecaoViewModel> value) {
    _$listCorrecaoAtom.reportWrite(value, super.listCorrecao, () {
      super.listCorrecao = value;
    });
  }

  final _$idNumberAtom = Atom(name: '_CorrecaoConsultaStoreBase.idNumber');

  @override
  String get idNumber {
    _$idNumberAtom.reportRead();
    return super.idNumber;
  }

  @override
  set idNumber(String value) {
    _$idNumberAtom.reportWrite(value, super.idNumber, () {
      super.idNumber = value;
    });
  }

  final _$idAtom = Atom(name: '_CorrecaoConsultaStoreBase.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$situacaoConsultaAtom =
      Atom(name: '_CorrecaoConsultaStoreBase.situacaoConsulta');

  @override
  SituacaoConsulta get situacaoConsulta {
    _$situacaoConsultaAtom.reportRead();
    return super.situacaoConsulta;
  }

  @override
  set situacaoConsulta(SituacaoConsulta value) {
    _$situacaoConsultaAtom.reportWrite(value, super.situacaoConsulta, () {
      super.situacaoConsulta = value;
    });
  }

  final _$newReplyAtom = Atom(name: '_CorrecaoConsultaStoreBase.newReply');

  @override
  bool get newReply {
    _$newReplyAtom.reportRead();
    return super.newReply;
  }

  @override
  set newReply(bool value) {
    _$newReplyAtom.reportWrite(value, super.newReply, () {
      super.newReply = value;
    });
  }

  final _$erroProfessorAtom =
      Atom(name: '_CorrecaoConsultaStoreBase.erroProfessor');

  @override
  bool? get erroProfessor {
    _$erroProfessorAtom.reportRead();
    return super.erroProfessor;
  }

  @override
  set erroProfessor(bool? value) {
    _$erroProfessorAtom.reportWrite(value, super.erroProfessor, () {
      super.erroProfessor = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_CorrecaoConsultaStoreBase.formKey');

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

  final _$initAsyncAction = AsyncAction('_CorrecaoConsultaStoreBase.init');

  @override
  Future init(ConsultaViewModel consulta) {
    return _$initAsyncAction.run(() => super.init(consulta));
  }

  final _$queryConsultaAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.queryConsulta');

  @override
  Future<void> queryConsulta(CorrecaoViewModel correcao) {
    return _$queryConsultaAsyncAction.run(() => super.queryConsulta(correcao));
  }

  final _$getConsultaIdAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.getConsultaId');

  @override
  Future<Map<dynamic, dynamic>> getConsultaId(String path) {
    return _$getConsultaIdAsyncAction.run(() => super.getConsultaId(path));
  }

  final _$registreErrorAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.registreError');

  @override
  Future<void> registreError(dynamic context, TipoCorrecao tipo, bool isAluno) {
    return _$registreErrorAsyncAction
        .run(() => super.registreError(context, tipo, isAluno));
  }

  final _$backConsultaAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.backConsulta');

  @override
  Future<void> backConsulta() {
    return _$backConsultaAsyncAction.run(() => super.backConsulta());
  }

  final _$loadDownloadedFilesAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.loadDownloadedFiles');

  @override
  Future<ArquivoObservableList> loadDownloadedFiles(
      {required List<Arquivo> viewFiles}) {
    return _$loadDownloadedFilesAsyncAction
        .run(() => super.loadDownloadedFiles(viewFiles: viewFiles));
  }

  final _$deleteFileAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.deleteFile');

  @override
  Future<void> deleteFile(ArquivoObservableList list, ArquivoViewModel file) {
    return _$deleteFileAsyncAction.run(() => super.deleteFile(list, file));
  }

  final _$requestDownloadAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.requestDownload');

  @override
  Future<void> requestDownload(
      ArquivoObservableList list, ArquivoViewModel file) {
    return _$requestDownloadAsyncAction
        .run(() => super.requestDownload(list, file));
  }

  final _$selectMultFilesAsyncAction =
      AsyncAction('_CorrecaoConsultaStoreBase.selectMultFiles');

  @override
  Future<dynamic> selectMultFiles() {
    return _$selectMultFilesAsyncAction.run(() => super.selectMultFiles());
  }

  final _$_CorrecaoConsultaStoreBaseActionController =
      ActionController(name: '_CorrecaoConsultaStoreBase');

  @override
  void habiliteSubmit() {
    final _$actionInfo = _$_CorrecaoConsultaStoreBaseActionController
        .startAction(name: '_CorrecaoConsultaStoreBase.habiliteSubmit');
    try {
      return super.habiliteSubmit();
    } finally {
      _$_CorrecaoConsultaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uploadFiles: ${uploadFiles},
listCorrecao: ${listCorrecao},
idNumber: ${idNumber},
id: ${id},
situacaoConsulta: ${situacaoConsulta},
newReply: ${newReply},
erroProfessor: ${erroProfessor},
formKey: ${formKey}
    ''';
  }
}
