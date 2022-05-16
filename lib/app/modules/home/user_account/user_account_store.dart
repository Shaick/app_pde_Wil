import 'package:app_pde/app/models/usuario.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/utlis/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'user_account_store.g.dart';

class UserAccountStore = _UserAccountStoreBase with _$UserAccountStore;

abstract class _UserAccountStoreBase extends BaseStore with Store {
  final FirebaseRepository _repository;
  final AuthController _authController;
  final bool isAluno;

  _UserAccountStoreBase(this._authController, this._repository, this.isAluno);

  @observable
  Usuario? _usuario;

  @computed
  Usuario? get user => _usuario;

  final formKey = GlobalKey<FormState>();

  final ctrlApelido = TextEditingController();

  final ctrlEmail = TextEditingController();

  final ctrlTelefone = TextEditingController();

  final ctrlCpf = TextEditingController();

  final ctrlBanco = TextEditingController();

  final ctrlAgenciaBanco = TextEditingController();

  final ctrlContaBanco = TextEditingController();

  String? validaApelido(String texto) => Validators.validarApelido(texto);

  String? validaEmail(String texto) => Validators.validarEmail(texto);

  String? validaTelefone(String texto) => Validators.validarTelefone(texto);

  String? validaCpf(String texto) => Validators.validarCpf(texto);

  String? validaBanco(String texto) => Validators.validarBanco(texto);

  String? validaAgencia(String texto) => Validators.validarAgencia(texto);

  String? validaConta(String texto) => Validators.validarConta(texto);

  void pushEditPage() => Modular.to.pushNamed(
      isAluno ? '/home/minha-conta/edit' : '/professor/minha-conta/edit');

  void pushome() =>
      Modular.to.pushReplacementNamed(isAluno ? '/home' : '/professor',
          arguments: _authController.user);

  void popPage() => Modular.to.pop();

  void initUserEditPage() {
    ctrlApelido.text = _usuario!.apelido ?? '';
    ctrlEmail.text = _usuario!.email;
    ctrlTelefone.text = _usuario!.telefone;
    ctrlCpf.text = _usuario!.cpf ?? '';
    ctrlBanco.text = _usuario!.banco ?? '';
    ctrlAgenciaBanco.text = _usuario!.agenciaBanco ?? '';
    ctrlContaBanco.text = _usuario!.contaBanco ?? '';
  }

  void setUser() => _usuario = _authController.user;

  @action
  void updateUserData() {
    if (formKey.currentState!.validate()) {
      final us = Usuario(
        materias: _usuario!.materias!.toList(),
        idPermissao: _usuario!.idPermissao,
        email: _usuario!.email,
        apelido: ctrlApelido.text.isEmpty ? null : ctrlApelido.text,
        telefone: ctrlTelefone.text,
        cpf: ctrlCpf.text.isEmpty ? null : ctrlCpf.text,
        banco: ctrlBanco.text.isEmpty ? null : ctrlBanco.text,
        agenciaBanco:
            ctrlAgenciaBanco.text.isEmpty ? null : ctrlAgenciaBanco.text,
        contaBanco: ctrlContaBanco.text.isEmpty ? null : ctrlContaBanco.text,
        id: _usuario!.id,
        termosAceitos: _usuario!.termosAceitos,
      );
      makeAsyncRequest<Usuario?>(() async {
        await _repository.updateUser(us);
        return _authController.fetchCurrentUser();
      }).then((newUser) {
        _usuario = newUser;
        return popPage();
      });
    }
  }
}
