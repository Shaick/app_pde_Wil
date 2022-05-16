// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserAccountStore on _UserAccountStoreBase, Store {
  Computed<Usuario?>? _$userComputed;

  @override
  Usuario? get user => (_$userComputed ??= Computed<Usuario?>(() => super.user,
          name: '_UserAccountStoreBase.user'))
      .value;

  final _$_usuarioAtom = Atom(name: '_UserAccountStoreBase._usuario');

  @override
  Usuario? get _usuario {
    _$_usuarioAtom.reportRead();
    return super._usuario;
  }

  @override
  set _usuario(Usuario? value) {
    _$_usuarioAtom.reportWrite(value, super._usuario, () {
      super._usuario = value;
    });
  }

  final _$_UserAccountStoreBaseActionController =
      ActionController(name: '_UserAccountStoreBase');

  @override
  void updateUserData() {
    final _$actionInfo = _$_UserAccountStoreBaseActionController.startAction(
        name: '_UserAccountStoreBase.updateUserData');
    try {
      return super.updateUserData();
    } finally {
      _$_UserAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
