// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financeiro_professor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FinanceiroProfessorStore on _FinanceiroProfessorStoreBase, Store {
  Computed<List<ConsultaViewModel>>? _$aReceberComputed;

  @override
  List<ConsultaViewModel> get aReceber => (_$aReceberComputed ??=
          Computed<List<ConsultaViewModel>>(() => super.aReceber,
              name: '_FinanceiroProfessorStoreBase.aReceber'))
      .value;
  Computed<List<ConsultaViewModel>>? _$recebidosComputed;

  @override
  List<ConsultaViewModel> get recebidos => (_$recebidosComputed ??=
          Computed<List<ConsultaViewModel>>(() => super.recebidos,
              name: '_FinanceiroProfessorStoreBase.recebidos'))
      .value;

  final _$successMessageAtom =
      Atom(name: '_FinanceiroProfessorStoreBase.successMessage');

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

  final _$_consultasAtom =
      Atom(name: '_FinanceiroProfessorStoreBase._consultas');

  @override
  ObservableList<Consulta> get _consultas {
    _$_consultasAtom.reportRead();
    return super._consultas;
  }

  @override
  set _consultas(ObservableList<Consulta> value) {
    _$_consultasAtom.reportWrite(value, super._consultas, () {
      super._consultas = value;
    });
  }

  final _$_FinanceiroProfessorStoreBaseActionController =
      ActionController(name: '_FinanceiroProfessorStoreBase');

  @override
  Future<void> fetchNecessaryData() {
    final _$actionInfo = _$_FinanceiroProfessorStoreBaseActionController
        .startAction(name: '_FinanceiroProfessorStoreBase.fetchNecessaryData');
    try {
      return super.fetchNecessaryData();
    } finally {
      _$_FinanceiroProfessorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
successMessage: ${successMessage},
aReceber: ${aReceber},
recebidos: ${recebidos}
    ''';
  }
}
