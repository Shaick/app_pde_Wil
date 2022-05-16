// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_aluno_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeAlunoStore on _HomeStoreBase, Store {
  final _$currentPageIndexAtom = Atom(name: '_HomeStoreBase.currentPageIndex');

  @override
  int get currentPageIndex {
    _$currentPageIndexAtom.reportRead();
    return super.currentPageIndex;
  }

  @override
  set currentPageIndex(int value) {
    _$currentPageIndexAtom.reportWrite(value, super.currentPageIndex, () {
      super.currentPageIndex = value;
    });
  }

  final _$getTokenAsyncAction = AsyncAction('_HomeStoreBase.getToken');

  @override
  Future<dynamic> getToken() {
    return _$getTokenAsyncAction.run(() => super.getToken());
  }

  final _$setupInteractedMessageAsyncAction =
      AsyncAction('_HomeStoreBase.setupInteractedMessage');

  @override
  Future<void> setupInteractedMessage() {
    return _$setupInteractedMessageAsyncAction
        .run(() => super.setupInteractedMessage());
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void changePage(int index) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.changePage');
    try {
      return super.changePage(index);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPageIndex: ${currentPageIndex}
    ''';
  }
}
