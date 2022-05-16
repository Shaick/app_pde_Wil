// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_chats_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AllChatsStore on _AllChatsStoreBase, Store {
  final _$chatsAtom = Atom(name: '_AllChatsStoreBase.chats');

  @override
  ObservableList<ChatViewModel> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<ChatViewModel> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  final _$downloadedFilesPathsAtom =
      Atom(name: '_AllChatsStoreBase.downloadedFilesPaths');

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

  final _$getDownloadedFilesAsyncAction =
      AsyncAction('_AllChatsStoreBase.getDownloadedFiles');

  @override
  Future<List<String>?> getDownloadedFiles() {
    return _$getDownloadedFilesAsyncAction
        .run(() => super.getDownloadedFiles());
  }

  final _$_AllChatsStoreBaseActionController =
      ActionController(name: '_AllChatsStoreBase');

  @override
  Future<void> fetchUserChats() {
    final _$actionInfo = _$_AllChatsStoreBaseActionController.startAction(
        name: '_AllChatsStoreBase.fetchUserChats');
    try {
      return super.fetchUserChats();
    } finally {
      _$_AllChatsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chats: ${chats},
downloadedFilesPaths: ${downloadedFilesPaths}
    ''';
  }
}
