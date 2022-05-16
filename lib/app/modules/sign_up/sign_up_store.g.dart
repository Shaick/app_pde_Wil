// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStoreBase, Store {
  final _$aceitouTermosAtom = Atom(name: '_SignUpStoreBase.aceitouTermos');

  @override
  bool get aceitouTermos {
    _$aceitouTermosAtom.reportRead();
    return super.aceitouTermos;
  }

  @override
  set aceitouTermos(bool value) {
    _$aceitouTermosAtom.reportWrite(value, super.aceitouTermos, () {
      super.aceitouTermos = value;
    });
  }

  final _$erroAtom = Atom(name: '_SignUpStoreBase.erro');

  @override
  String get erro {
    _$erroAtom.reportRead();
    return super.erro;
  }

  @override
  set erro(String value) {
    _$erroAtom.reportWrite(value, super.erro, () {
      super.erro = value;
    });
  }

  final _$claimAtom = Atom(name: '_SignUpStoreBase.claim');

  @override
  int get claim {
    _$claimAtom.reportRead();
    return super.claim;
  }

  @override
  set claim(int value) {
    _$claimAtom.reportWrite(value, super.claim, () {
      super.claim = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_SignUpStoreBase.submit');

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  @override
  String toString() {
    return '''
aceitouTermos: ${aceitouTermos},
erro: ${erro},
claim: ${claim}
    ''';
  }
}
