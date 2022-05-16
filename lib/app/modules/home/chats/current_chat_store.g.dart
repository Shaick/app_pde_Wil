// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentChatStore on _CurrentChatStoreBase, Store {
  final _$onNewMessageAtom = Atom(name: '_CurrentChatStoreBase.onNewMessage');

  @override
  ObservableStream<List<MensagemViewModel>>? get onNewMessage {
    _$onNewMessageAtom.reportRead();
    return super.onNewMessage;
  }

  @override
  set onNewMessage(ObservableStream<List<MensagemViewModel>>? value) {
    _$onNewMessageAtom.reportWrite(value, super.onNewMessage, () {
      super.onNewMessage = value;
    });
  }

  final _$pickedFilesAtom = Atom(name: '_CurrentChatStoreBase.pickedFiles');

  @override
  ObservableList<ArquivoViewModel> get pickedFiles {
    _$pickedFilesAtom.reportRead();
    return super.pickedFiles;
  }

  @override
  set pickedFiles(ObservableList<ArquivoViewModel> value) {
    _$pickedFilesAtom.reportWrite(value, super.pickedFiles, () {
      super.pickedFiles = value;
    });
  }

  final _$downloadedFilesPathsAtom =
      Atom(name: '_CurrentChatStoreBase.downloadedFilesPaths');

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

  final _$pickFilesAsyncAction = AsyncAction('_CurrentChatStoreBase.pickFiles');

  @override
  Future<void> pickFiles() {
    return _$pickFilesAsyncAction.run(() => super.pickFiles());
  }

  final _$getDownloadedFilesPathsAsyncAction =
      AsyncAction('_CurrentChatStoreBase.getDownloadedFilesPaths');

  @override
  Future<void> getDownloadedFilesPaths() {
    return _$getDownloadedFilesPathsAsyncAction
        .run(() => super.getDownloadedFilesPaths());
  }

  final _$_CurrentChatStoreBaseActionController =
      ActionController(name: '_CurrentChatStoreBase');

  @override
  void removeFile(ArquivoViewModel file) {
    final _$actionInfo = _$_CurrentChatStoreBaseActionController.startAction(
        name: '_CurrentChatStoreBase.removeFile');
    try {
      return super.removeFile(file);
    } finally {
      _$_CurrentChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
onNewMessage: ${onNewMessage},
pickedFiles: ${pickedFiles},
downloadedFilesPaths: ${downloadedFilesPaths}
    ''';
  }
}
