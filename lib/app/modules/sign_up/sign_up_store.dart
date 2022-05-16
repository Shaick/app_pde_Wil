
import 'package:app_pde/app/modules/sign_up/select_user_store.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/utlis/mask_map.dart';
import 'package:app_pde/app/shared/utlis/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase extends BaseStore with Store {
  final AuthController _authController;
 

  _SignUpStoreBase(this._authController);

  @observable
  bool aceitouTermos = false;

  @observable
  String erro = "";

  
  @observable
  int claim = Modular.get<SelectUserStore>().claim;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController ctrlEmail = TextEditingController();

  TextEditingController ctrlSenha = TextEditingController();

  TextEditingController ctrlConfirmaSenha = TextEditingController();

  TextEditingController ctrlTelefone = TextEditingController();

  void aceitarTermos(bool value) => aceitouTermos = value;

  String? validaEmail(String texto) => Validators.validarEmail(texto);

  String? validaSenha(String texto) => Validators.validarSenha(ctrlSenha.text);

  String? validaConfirmaSenha(String texto) =>
      Validators.validarConfirmaSenha(ctrlSenha.text, ctrlConfirmaSenha.text);

  String? validaTelefone(String texto) =>
      Validators.validarTelefone(ctrlTelefone.text);

  @action
  Future<void> submit() async {
       makeAsyncRequest(() async {

      return await _authController.createUser(
          claim,
          ctrlEmail.text.trim(),
          ctrlSenha.text.trim(),
          masks['cel']!.unmaskText(ctrlTelefone.text).trim(),
          aceitouTermos).onError((error, stackTrace) =>  errorSignIn(error.toString()));
    });
  }
  void errorSignIn(String error){
    print(error);
    switch (error){
      case "The user with the provided phone number already exists.": 
      erro = "O usuário com o número de telefone fornecido já existe.";
      break;

      case "The email address is already in use by another account.":
      erro = "O endereço de e-mail já está sendo usado por outra conta.";
      break;

      default: erro = "Desculpe, ocorreu um erro.";
      print('${error}');
    }
  }
}
