import 'package:app_pde/app/models/dtos/consulta_a_receber_dto.dart';
import 'package:app_pde/app/models/pedido_saque_professor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pedido_saque_professor_dto.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class PedidoSaqueProfessorDTO {
  @JsonKey(ignore: true)
  final String? id;
  final String idProfessor;
  final String email;
  final String telefone;
  final List<ConsultaAReceberDTO> consultasAReceber;
  final int dataPedido;

  const PedidoSaqueProfessorDTO({
    this.id,
    required this.idProfessor,
    required this.email,
    required this.telefone,
    required this.consultasAReceber,
    required this.dataPedido,
  });

  factory PedidoSaqueProfessorDTO.fromJson(Map<String, dynamic> json) =>
      _$PedidoSaqueProfessorDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PedidoSaqueProfessorDTOToJson(this);

  factory PedidoSaqueProfessorDTO.fromDomain(PedidoSaqueProfessor model) {
    return PedidoSaqueProfessorDTO(
      id: model.id,
      idProfessor: model.idProfessor,
      email: model.email,
      telefone: model.telefone,
      dataPedido: model.dataPedido.millisecondsSinceEpoch,
      consultasAReceber: model.consultasAReceber
          .map((e) => ConsultaAReceberDTO.fromDomain(e))
          .toList(),
    );
  }
}
