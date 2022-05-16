import 'package:json_annotation/json_annotation.dart';

import '../consulta_a_receber.dart';

part 'consulta_a_receber_dto.g.dart';

@JsonSerializable(anyMap: true)
class ConsultaAReceberDTO {
  final String idConsulta;
  final String idMateria;
  final double valorProfessor;

  const ConsultaAReceberDTO({
    required this.idConsulta,
    required this.idMateria,
    required this.valorProfessor,
  });

  factory ConsultaAReceberDTO.fromJson(Map<String, dynamic> json) =>
      _$ConsultaAReceberDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ConsultaAReceberDTOToJson(this);

  factory ConsultaAReceberDTO.fromDomain(ConsultaAReceber model) {
    return ConsultaAReceberDTO(
      idConsulta: model.idConsulta,
      idMateria: model.idMateria,
      valorProfessor: model.valorProfessor,
    );
  }
}
