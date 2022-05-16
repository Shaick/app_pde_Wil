import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/repositories/professor_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';

import '../professor_store.dart';

part 'orcamento_professor_store.g.dart';

class OrcamentoProfessorStore = _OrcamentoProfessorStore
    with _$OrcamentoProfessorStore;

abstract class _OrcamentoProfessorStore extends BaseStore with Store {
  final ProfessorRepository _repository;
  final ProfessorStore _professorStore;
  final FirebaseAuth _firebaseAuth;

  _OrcamentoProfessorStore(
      this._repository, this._professorStore, this._firebaseAuth);

  late ConsultaViewModel consulta;

  final ctrlValorProfessor = TextEditingController();

  @action
  String? validaValor(String texto) {
    if (texto.isEmpty) {
      return "Por favor insira uma valor";
    }
    return null;
  }

  @action
  Future<void> saveOrcamento() {
    var _db = _repository.db;
    final pathOrcamento = _db
        .child('consultas')
        .child('ativas')
        .child('${consulta.id}')
        .child('Orcamentos')
        .child(_firebaseAuth.currentUser!.uid);

    return makeAsyncRequest(() async {
      await pathOrcamento.set(setOrcamento());
    }).then((results) async {
      await _professorStore.getConsultasProfessor();
      popPage();
    });
  }

  setOrcamento() {
    var valorAtividade;
    if (ctrlValorProfessor.text.isNotEmpty &&
        ctrlValorProfessor.text.length >= 4) {
      valorAtividade = ctrlValorProfessor.text
          .replaceAll('R\$', '')
          .replaceAll(',00', '')
          .replaceAll('.', '')
          .trim();
    } else if (ctrlValorProfessor.text.isNotEmpty) {
      valorAtividade = ctrlValorProfessor.text
          .replaceAll('R\$', '')
          .replaceAll(',', '.')
          .trim();
    }

    return {
      'IDProfessor': _firebaseAuth.currentUser!.uid,
      'ValorProfessor':
          valorAtividade != null ? double.parse(valorAtividade) : 0,
      'NomeFantasia': '',
      'AlunoJaViuOrcamento': false,
      'Escolhido': false
    };
  }

  void popPage() => Modular.to.pushReplacementNamed('/professor');
}
