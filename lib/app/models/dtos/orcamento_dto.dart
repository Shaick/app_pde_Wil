import 'package:app_pde/app/models/orcamento.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orcamento_dto.g.dart';

@JsonSerializable(anyMap: true)
class OrcamentoDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'IDProfessor')
  final String idProfessor;
  @JsonKey(name: 'NomeFantasia')
  final String? nomeFantasia;
  @JsonKey(name: 'Escolhido')
  final bool? escolhido;
  @JsonKey(name: 'AlunoJaViuOrcamento')
  final bool? alunoJaViuOrcamento;
  @JsonKey(name: 'ValorConsulta')
  final double? valorConsulta;
  @JsonKey(name: 'ValorProfessor')
  final double? valorProfessor;

  const OrcamentoDTO({
      this.id,
      required this.idProfessor,
      this.nomeFantasia,
      this.escolhido,
      this.alunoJaViuOrcamento,
      this.valorConsulta,
      this.valorProfessor});

  factory OrcamentoDTO.fromJson(Map json) => _$OrcamentoDTOFromJson(json);
  Map<String, dynamic> toJson() => _$OrcamentoDTOToJson(this);

  Orcamento toDomain() {
    return Orcamento(
      id: id ?? '',
      idProfessor: idProfessor,
      nomeFantasia: nomeFantasia,
      escolhido: escolhido,
      alunoJaViuOrcamento: alunoJaViuOrcamento,
      valorConsulta: valorConsulta ?? 0,
      valorProfessor: valorProfessor ?? 0,
    );
  }

  factory OrcamentoDTO.fromDomain(Orcamento model) {
    return OrcamentoDTO(
      id: model.id,
      idProfessor: model.idProfessor,
      nomeFantasia: model.nomeFantasia ?? '',
      escolhido: model.escolhido,
      alunoJaViuOrcamento: model.alunoJaViuOrcamento,
      valorProfessor: model.valorProfessor ?? 0,
      valorConsulta: model.valorConsulta ?? 0,
    );
  }

  OrcamentoDTO copyWith(
      {String? id,
      String? idProfessor,
      String? nomefantasia,
      bool? escolhido,
      bool? alunoJaViuOrcamento,
      double? valorProfessor,
      double? valorConsulta}) {
    return OrcamentoDTO(
      id: id ?? this.id,
      idProfessor: idProfessor ?? this.idProfessor,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      escolhido: escolhido ?? this.escolhido,
      alunoJaViuOrcamento: alunoJaViuOrcamento ?? this.alunoJaViuOrcamento,
      valorConsulta: valorConsulta ?? this.valorConsulta,
      valorProfessor: valorProfessor ?? this.valorProfessor,
    );
  }
}
