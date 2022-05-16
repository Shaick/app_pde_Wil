import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/materia.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/repositories/aluno_repository.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/controllers/materias_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'minhas_consultas_store.g.dart';

class MinhasConsultasStore = _MinhasConsultasStoreBase
    with _$MinhasConsultasStore;

abstract class _MinhasConsultasStoreBase extends BaseStore with Store {
  final AlunoRepository _repository;
  final MateriasStore _materiasStore;

  _MinhasConsultasStoreBase(this._repository, this._materiasStore);

  void pushDetalhesConsultaPage(ConsultaViewModel consulta) {
    Modular.to.pushNamed(
        '/home/minhas-consultas/${consulta.idNumerico}/detalhes',
        arguments: consulta);
  }

  Future<void> fetchNecessaryData() {
    return fetchAllConsultas();
  }

  @action
  Future<void> fetchAllConsultas() {
    return makeAsyncRequest(() {
      return Future.wait([
        _repository.getConsultasAndamento(),
        _repository.getConsultasPendentes(),
        _repository.getConsultasFinalizadas(),
      ]);
    }).then((results) async {
      if (results == null) return;
      final consultas = results.expand((element) => element).toList();
      _consultas = _consultasComMateria(
        materias: _materiasStore.materias,
        consultas: consultas,
      ).asObservable();
    });
  }

  List<ConsultaViewModel> _consultasComMateria({
    required List<Materia> materias,
    required List<Consulta> consultas,
  }) {
    return consultas.map((consulta) {
      final materia = materias.singleWhere(
        (materia) => materia.id == consulta.idMateria,
      );
      return ConsultaViewModel.aluno(
        consulta,
        idMateria: materia.id,
        nomeMateria: materia.nome ?? 'Desconhecido',
      );
    }).toList();
  }

  @observable
  ObservableList<ConsultaViewModel> _consultas = ObservableList();

  @computed
  List<ConsultaViewModel> get consultasAndamento => _consultas
      .where((element) => element.situacao == SituacaoConsulta.andamento)
      .toList();

  @computed
  List<ConsultaViewModel> get consultasPendentes => _consultas
      .where((element) => element.situacao == SituacaoConsulta.pendente)
      .toList();

  @computed
  List<ConsultaViewModel> get consultasFinalizadas => _consultas
      .where((element) => element.situacao == SituacaoConsulta.finalizada)
      .toList();
}
