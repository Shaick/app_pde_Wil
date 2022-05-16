// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerStore on _DrawerStoreBase, Store {
  final _$currentItemIndexAtom =
      Atom(name: '_DrawerStoreBase.currentItemIndex');

  @override
  int get currentItemIndex {
    _$currentItemIndexAtom.reportRead();
    return super.currentItemIndex;
  }

  @override
  set currentItemIndex(int value) {
    _$currentItemIndexAtom.reportWrite(value, super.currentItemIndex, () {
      super.currentItemIndex = value;
    });
  }

  final _$_DrawerStoreBaseActionController =
      ActionController(name: '_DrawerStoreBase');

  @override
  void selectItem(int index) {
    final _$actionInfo = _$_DrawerStoreBaseActionController.startAction(
        name: '_DrawerStoreBase.selectItem');
    try {
      return super.selectItem(index);
    } finally {
      _$_DrawerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentItemIndex: ${currentItemIndex}
    ''';
  }
}
