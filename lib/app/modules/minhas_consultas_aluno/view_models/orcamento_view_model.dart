import 'package:app_pde/app/models/orcamento.dart';

class OrcamentoViewModel {
  final String? id;
  final String idProfessor;
  final String? nomeFantasia;
  final double? valorConsulta;
  final double? valorProfessor;
  final bool? escolhido;
  final bool? alunoJaViuOrcamento;

  const OrcamentoViewModel({
    this.id,
    required this.idProfessor,
    this.nomeFantasia,
    this.valorConsulta,
    this.valorProfessor,
    this.escolhido,
    this.alunoJaViuOrcamento,
  });

  OrcamentoViewModel copyWith({
    String? id,
    String? idProfessor,
    String? nomeFantasia,
    double? valorConsulta,
    double? valorProfessor,
    bool? escolhido,
    bool? alunoJaViuOrcamento,
  }) {
    return OrcamentoViewModel(
      id: id ?? this.id,
      idProfessor: idProfessor ?? this.idProfessor,
      valorConsulta: valorConsulta ?? this.valorConsulta,
      valorProfessor: valorProfessor ?? this.valorProfessor,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      escolhido: escolhido ?? this.escolhido,
      alunoJaViuOrcamento: alunoJaViuOrcamento ?? this.alunoJaViuOrcamento,
    );
  }

  Orcamento toDomain() {
    return Orcamento(
      id: id ?? '',
      idProfessor: idProfessor,
      nomeFantasia: nomeFantasia,
      valorConsulta: valorConsulta ?? 0,
      valorProfessor: valorProfessor ?? 0,
      escolhido: escolhido ?? false,
      alunoJaViuOrcamento: alunoJaViuOrcamento ?? false
    );
  }

  factory OrcamentoViewModel.fromDomain(
    Orcamento orcamento, {
    required String? id,
    required String idProfessor,
    required String? nomeFantasia,
    required double valorConsulta,
    required double? valorProfessor,
  }) {
    return OrcamentoViewModel(
      id: id,
      idProfessor: orcamento.idProfessor,
      valorConsulta: orcamento.valorConsulta,
      nomeFantasia: orcamento.nomeFantasia,
      valorProfessor: orcamento.valorProfessor,
      alunoJaViuOrcamento: orcamento.alunoJaViuOrcamento,
      escolhido: orcamento.escolhido,
    );
  }
}
