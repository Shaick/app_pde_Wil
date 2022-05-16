import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:intl/intl.dart';

class ConsultaAReceber {
  final String idConsulta;
  final String idMateria;
  final double valorProfessor;

  const ConsultaAReceber({
    required this.idConsulta,
    required this.idMateria,
    required this.valorProfessor,
  });

  factory ConsultaAReceber.fromViewModel(ConsultaViewModel viewModel) {
    final parsedValue = NumberFormat.currency(symbol: 'R\$').parse(viewModel.valor);
    return ConsultaAReceber(
      idConsulta: viewModel.id,
      idMateria: viewModel.idMateria,
      valorProfessor: parsedValue as double,
    );
  }
}
