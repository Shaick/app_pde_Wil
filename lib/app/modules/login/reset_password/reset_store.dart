import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/utlis/validators.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'reset_store.g.dart';

class ResetStore = _ResetStoreBase with _$ResetStore;

abstract class _ResetStoreBase extends BaseStore with Store {
  @observable
  String? successMessage;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  TextEditingController ctrlLogin = new TextEditingController();

  AuthController authController = Modular.get<AuthController>();

  String? validaEmail(String texto) => Validators.validarResetEmail(texto);

  @action
  Future resetCredential() async {
    successMessage = null;
    if (formKey.currentState!.validate()) {
      makeAsyncRequest(() async {
        return authController.resetUserCredentials(ctrlLogin.text);
      }).then((_) => successMessage = 'Foi enviado um email para ${ctrlLogin.text}, com o link de recuperação de senha!');
    }
  }
}
