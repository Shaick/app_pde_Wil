import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/consulta_a_receber.dart';
import 'package:app_pde/app/models/materia.dart';
import 'package:app_pde/app/models/pedido_saque_professor.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/repositories/professor_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/controllers/materias_store.dart';
import 'package:app_pde/app/shared/utlis/database_string_cleaner.dart';
import 'package:mobx/mobx.dart';

part 'financeiro_professor_store.g.dart';

class FinanceiroProfessorStore = _FinanceiroProfessorStoreBase
    with _$FinanceiroProfessorStore;

abstract class _FinanceiroProfessorStoreBase extends BaseStore with Store {
  final ProfessorRepository _repository;
  final AuthController _authController;
  final MateriasStore _materiasStore;

  _FinanceiroProfessorStoreBase(
    this._repository,
    this._authController,
    this._materiasStore,
  );

  @observable
  String? successMessage;

  @action
  Future<void> fetchNecessaryData() {
    return makeAsyncRequest(_repository.getConsultasConcluidasProfessor)
        .then((result) {
      if (result != null) {
        result.sort(
          (previous, next) => next.dataFim.compareTo(previous.dataFim),
        );
        _consultas = ObservableList.of(result);
      }
    });
  }

  @observable
  ObservableList<Consulta> _consultas = ObservableList();

  List<Consulta> _filterByLastFifteenDays(List<Consulta> list) {
    return list.where((e) => _checkConsultaDate(e.dataInicio)).toList();
  }

  double calculateWithdrawAmount() {
    final list = _filterByLastFifteenDays(_consultas);
    return list.fold<double>(0, (previousValue, element) {
      return previousValue + element.valorProfessor;
    });
  }

  bool _checkConsultaDate(DateTime dateTime) {
    final now = DateTime.now();
    final fifteenDaysBefore = now.subtract(const Duration(days: 15));
    return dateTime.isAfter(fifteenDaysBefore);
  }

  @computed
  List<ConsultaViewModel> get aReceber {
    final consultas = _consultas.where((element) {
      if (element.professorPago == null || element.professorPago == false)
        return true;
      return false;
    }).toList();
    return _consultasComMateria(
      materias: _materiasStore.materias,
      consultas: consultas,
    );
  }

  @computed
  List<ConsultaViewModel> get recebidos {
    final consultas = _consultas
        .where((consulta) => consulta.professorPago ?? false)
        .toList();
    return _consultasComMateria(
      materias: _materiasStore.materias,
      consultas: consultas,
    );
  }

  List<ConsultaViewModel> _consultasComMateria({
    required List<Materia> materias,
    required List<Consulta> consultas,
  }) {
    return consultas.map((consulta) {
      final materia = materias.singleWhere(
        (materia) => materia.id == consulta.idMateria,
      );
      return ConsultaViewModel.professor(
        consulta,
        idMateria: materia.id,
        nomeMateria: materia.nome ?? 'Desconhecido',
      );
    }).toList();
  }

  Future<void> requestWithdraw() {
    final telefone = DatabaseStringCleaner.cleanPhoneNumber(
      _authController.user!.telefone,
    );
    final consultasAReceber =
        aReceber.map((e) => ConsultaAReceber.fromViewModel(e)).toList();
    final pedido = PedidoSaqueProfessor(
      idProfessor: _authController.user!.id,
      email: _authController.user!.email,
      telefone: telefone,
      consultasAReceber: consultasAReceber,
      dataPedido: DateTime.now(),
    );
    return makeAsyncRequest(() {
      return _repository.requestProfessorWithdraw(pedido);
    }).then((_) => successMessage = 'Sua solicitação foi enviada!');
  }
}
