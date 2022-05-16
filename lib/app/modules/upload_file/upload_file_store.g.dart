// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UploadFileStore on _UploadFileStore, Store {
  final _$uploadFilesAtom = Atom(name: '_UploadFileStore.uploadFiles');

  @override
  ObservableList<ArquivoViewModel> get uploadFiles {
    _$uploadFilesAtom.reportRead();
    return super.uploadFiles;
  }

  @override
  set uploadFiles(ObservableList<ArquivoViewModel> value) {
    _$uploadFilesAtom.reportWrite(value, super.uploadFiles, () {
      super.uploadFiles = value;
    });
  }

  final _$badFilesAtom = Atom(name: '_UploadFileStore.badFiles');

  @override
  ObservableList<ArquivoViewModel> get badFiles {
    _$badFilesAtom.reportRead();
    return super.badFiles;
  }

  @override
  set badFiles(ObservableList<ArquivoViewModel> value) {
    _$badFilesAtom.reportWrite(value, super.badFiles, () {
      super.badFiles = value;
    });
  }

  final _$selectMultFilesAsyncAction =
      AsyncAction('_UploadFileStore.selectMultFiles');

  @override
  Future<void> selectMultFiles() {
    return _$selectMultFilesAsyncAction.run(() => super.selectMultFiles());
  }

  final _$_UploadFileStoreActionController =
      ActionController(name: '_UploadFileStore');

  @override
  void removeFile(ArquivoViewModel file) {
    final _$actionInfo = _$_UploadFileStoreActionController.startAction(
        name: '_UploadFileStore.removeFile');
    try {
      return super.removeFile(file);
    } finally {
      _$_UploadFileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uploadFiles: ${uploadFiles},
badFiles: ${badFiles}
    ''';
  }
}
