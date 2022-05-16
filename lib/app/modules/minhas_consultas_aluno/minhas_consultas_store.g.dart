// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minhas_consultas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MinhasConsultasStore on _MinhasConsultasStoreBase, Store {
  Computed<List<ConsultaViewModel>>? _$consultasAndamentoComputed;

  @override
  List<ConsultaViewModel> get consultasAndamento =>
      (_$consultasAndamentoComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasAndamento,
              name: '_MinhasConsultasStoreBase.consultasAndamento'))
          .value;
  Computed<List<ConsultaViewModel>>? _$consultasPendentesComputed;

  @override
  List<ConsultaViewModel> get consultasPendentes =>
      (_$consultasPendentesComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasPendentes,
              name: '_MinhasConsultasStoreBase.consultasPendentes'))
          .value;
  Computed<List<ConsultaViewModel>>? _$consultasFinalizadasComputed;

  @override
  List<ConsultaViewModel> get consultasFinalizadas =>
      (_$consultasFinalizadasComputed ??= Computed<List<ConsultaViewModel>>(
              () => super.consultasFinalizadas,
              name: '_MinhasConsultasStoreBase.consultasFinalizadas'))
          .value;

  final _$_consultasAtom = Atom(name: '_MinhasConsultasStoreBase._consultas');

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

  final _$_MinhasConsultasStoreBaseActionController =
      ActionController(name: '_MinhasConsultasStoreBase');

  @override
  Future<void> fetchAllConsultas() {
    final _$actionInfo = _$_MinhasConsultasStoreBaseActionController
        .startAction(name: '_MinhasConsultasStoreBase.fetchAllConsultas');
    try {
      return super.fetchAllConsultas();
    } finally {
      _$_MinhasConsultasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
consultasAndamento: ${consultasAndamento},
consultasPendentes: ${consultasPendentes},
consultasFinalizadas: ${consultasFinalizadas}
    ''';
  }
}
