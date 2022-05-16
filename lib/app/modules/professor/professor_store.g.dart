// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfessorStore on _ProfessorStoreBase, Store {
  Computed<List<ConsultaViewModel>>? _$consultasDisponiveisComputed;

  @override
  List<ConsultaViewModel> get consultasDisponiveis =>
      (_$consultasDisponiveisComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasDisponiveis,
              name: '_ProfessorStoreBase.consultasDisponiveis'))
          .value;
  Computed<List<ConsultaViewModel>>? _$consultasAtendidasComputed;

  @override
  List<ConsultaViewModel> get consultasAtendidas =>
      (_$consultasAtendidasComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasAtendidas,
              name: '_ProfessorStoreBase.consultasAtendidas'))
          .value;
  Computed<List<ConsultaViewModel>>? _$consultasConcluidasComputed;

  @override
  List<ConsultaViewModel> get consultasConcluidas =>
      (_$consultasConcluidasComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasConcluidas,
              name: '_ProfessorStoreBase.consultasConcluidas'))
          .value;
  Computed<List<ConsultaViewModel>>? _$consultasOrcadasComputed;

  @override
  List<ConsultaViewModel> get consultasOrcadas =>
      (_$consultasOrcadasComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasOrcadas,
              name: '_ProfessorStoreBase.consultasOrcadas'))
          .value;

  final _$consultaAtom = Atom(name: '_ProfessorStoreBase.consulta');

  @override
  ConsultaViewModel get consulta {
    _$consultaAtom.reportRead();
    return super.consulta;
  }

  @override
  set consulta(ConsultaViewModel value) {
    _$consultaAtom.reportWrite(value, super.consulta, () {
      super.consulta = value;
    });
  }

  final _$tsAtualAtom = Atom(name: '_ProfessorStoreBase.tsAtual');

  @override
  int get tsAtual {
    _$tsAtualAtom.reportRead();
    return super.tsAtual;
  }

  @override
  set tsAtual(int value) {
    _$tsAtualAtom.reportWrite(value, super.tsAtual, () {
      super.tsAtual = value;
    });
  }

  final _$_consultasAtom = Atom(name: '_ProfessorStoreBase._consultas');

  @override
  ObservableList<ConsultaViewModel> get _consultas {
    _$_consultasAtom.reportRead();
    return super._consultas;
  }

  @override
  set _consultas(ObservableList<ConsultaViewModel> value) {
    _$_consultasAtom.reportWrite(value, super._consultas, () {
      super._consultas = value;
    });
  }

  final _$getConsultasProfessorAsyncAction =
      AsyncAction('_ProfessorStoreBase.getConsultasProfessor');

  @override
  Future<void> getConsultasProfessor() {
    return _$getConsultasProfessorAsyncAction
        .run(() => super.getConsultasProfessor());
  }

  final _$getTokenAsyncAction = AsyncAction('_ProfessorStoreBase.getToken');

  @override
  Future<dynamic> getToken() {
    return _$getTokenAsyncAction.run(() => super.getToken());
  }

  final _$_ProfessorStoreBaseActionController =
      ActionController(name: '_ProfessorStoreBase');

  @override
  Future<void> pushOrcamentoPage(ConsultaViewModel consulta) {
    final _$actionInfo = _$_ProfessorStoreBaseActionController.startAction(
        name: '_ProfessorStoreBase.pushOrcamentoPage');
    try {
      return super.pushOrcamentoPage(consulta);
    } finally {
      _$_ProfessorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
consulta: ${consulta},
tsAtual: ${tsAtual},
consultasDisponiveis: ${consultasDisponiveis},
consultasAtendidas: ${consultasAtendidas},
consultasConcluidas: ${consultasConcluidas},
consultasOrcadas: ${consultasOrcadas}
    ''';
  }
}
