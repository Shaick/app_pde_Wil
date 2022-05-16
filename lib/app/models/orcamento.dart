import 'package:equatable/equatable.dart';

class Orcamento extends Equatable {
  final String id;
  final String idProfessor;
  final String? nomeFantasia;
  final bool? escolhido;
  final bool? alunoJaViuOrcamento;
  final double? valorConsulta;
  final double? valorProfessor;

  const Orcamento(
      {required this.id,
      required this.idProfessor,
      this.nomeFantasia,
      this.escolhido,
      this.alunoJaViuOrcamento,
      this.valorConsulta,
      this.valorProfessor});

  @override
  List<Object?> get props {
    return [
      id,
      idProfessor,
      nomeFantasia,
      escolhido,
      alunoJaViuOrcamento,
      valorConsulta,
      valorProfessor
    ];
  }
}
