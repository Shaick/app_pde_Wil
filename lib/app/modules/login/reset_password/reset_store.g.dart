// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetStore on _ResetStoreBase, Store {
  final _$successMessageAtom = Atom(name: '_ResetStoreBase.successMessage');

  @override
  String? get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String? value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  final _$resetCredentialAsyncAction =
      AsyncAction('_ResetStoreBase.resetCredential');

  @override
  Future<dynamic> resetCredential() {
    return _$resetCredentialAsyncAction.run(() => super.resetCredential());
  }

  @override
  String toString() {
    return '''
successMessage: ${successMessage}
    ''';
  }
}
