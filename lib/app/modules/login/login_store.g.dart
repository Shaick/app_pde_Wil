// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  final _$obscureTextAtom = Atom(name: '_LoginStoreBase.obscureText');

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  final _$isBiometricAuthOnAtom =
      Atom(name: '_LoginStoreBase.isBiometricAuthOn');

  @override
  bool get isBiometricAuthOn {
    _$isBiometricAuthOnAtom.reportRead();
    return super.isBiometricAuthOn;
  }

  @override
  set isBiometricAuthOn(bool value) {
    _$isBiometricAuthOnAtom.reportWrite(value, super.isBiometricAuthOn, () {
      super.isBiometricAuthOn = value;
    });
  }

  final _$isBiometricAuthAvailableAtom =
      Atom(name: '_LoginStoreBase.isBiometricAuthAvailable');

  @override
  bool get isBiometricAuthAvailable {
    _$isBiometricAuthAvailableAtom.reportRead();
    return super.isBiometricAuthAvailable;
  }

  @override
  set isBiometricAuthAvailable(bool value) {
    _$isBiometricAuthAvailableAtom
        .reportWrite(value, super.isBiometricAuthAvailable, () {
      super.isBiometricAuthAvailable = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_LoginStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$checkBiometricAvailabilityAsyncAction =
      AsyncAction('_LoginStoreBase.checkBiometricAvailability');

  @override
  Future<void> checkBiometricAvailability() {
    return _$checkBiometricAvailabilityAsyncAction
        .run(() => super.checkBiometricAvailability());
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  void setObscureText() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setObscureText');
    try {
      return super.setObscureText();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleBiometricAuth() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.toggleBiometricAuth');
    try {
      return super.toggleBiometricAuth();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureText: ${obscureText},
isBiometricAuthOn: ${isBiometricAuthOn},
isBiometricAuthAvailable: ${isBiometricAuthAvailable}
    ''';
  }
}
