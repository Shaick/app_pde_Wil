import 'package:app_pde/app/repositories/auth_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/utlis/biometric_authentication.dart';
import 'package:app_pde/app/shared/utlis/user_secure_storage.dart';
import 'package:app_pde/app/shared/utlis/validators.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase extends BaseStore with Store {
  final AuthController _authController;
  final UserSecureStorage _userStorage;
  final BiometricAuthentication _bioAuthentication;
  final AuthRepository _authRepository;

  _LoginStoreBase(this._authController, this._bioAuthentication,
      this._userStorage, this._authRepository);

  @observable
  bool obscureText = false;

  @observable
  bool isBiometricAuthOn = false;

  @observable
  bool isBiometricAuthAvailable = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController ctrlLogin = TextEditingController();

  TextEditingController ctrlSenha = TextEditingController();

  String? validaEmail(String texto) => Validators.validarEmail(texto);

  String? validaSenha(String texto) => Validators.validarSenha(texto);

  /*if (_authController.user!.idPermissao.isEmpty) {
      return "Cadastro ainda em análise";
    }
    return null;*/

  @action
  void setObscureText() => obscureText = !obscureText;

  @action
  void toggleBiometricAuth() => isBiometricAuthOn = !isBiometricAuthOn;

  @action
  Future<void> init() async {
    final userCredentials = await _userStorage.getUserCredentials();
    if (userCredentials != null) ctrlLogin.text = userCredentials.email;
    if (await _canAuthenticateWithBiometrics()) {
      return _authenticateWithBiometrics();
    }
  }

  @action
  Future<void> checkBiometricAvailability() async {
    isBiometricAuthAvailable = await _bioAuthentication.isAvailable();
    isBiometricAuthOn = await _userStorage.isBiometricAuthActive();
  }

  Future<bool> _canAuthenticateWithBiometrics() async {
    return (await _bioAuthentication.isAvailable() &&
        await _userStorage.userCredentialsExist());
  }

  Future<void> _authenticateWithBiometrics() async {
    return makeAsyncRequest(() async {
      final isAuthenticated = await _bioAuthentication.tryAuthentication();
      if (isAuthenticated) {
        final userCredentials = await _userStorage.getUserCredentials();
        ctrlSenha.text = userCredentials!.password!;
        await _authRepository.signInWithEmailAndPassword(
            email: userCredentials.email, password: userCredentials.password!);
        return _authController.resolveLoggedInUser();
      }
    });
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      ctrlLogin.text = ctrlLogin.text.trim();
      makeAsyncRequest(() async {
        await _userStorage.saveUserEmail(UserStorageCredentials(
            email: ctrlLogin.text, password: ctrlSenha.text));
        await _authRepository
            .signInWithEmailAndPassword(
                email: ctrlLogin.text, password: ctrlSenha.text)
            .then((value) => null);
        if (isBiometricAuthOn) {
          await _userStorage.saveUserPassword(UserStorageCredentials(
              email: ctrlLogin.text, password: ctrlSenha.text));
          await _userStorage.saveBiometricAuthPreferences(isBiometricAuthOn);
        } else {
          await _userStorage.clearStoragePassword();
        }
        return _authController.resolveLoggedInUser();
      });
    }
  }
}
