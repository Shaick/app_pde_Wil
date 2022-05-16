// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_saque_professor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PedidoSaqueProfessorDTO _$PedidoSaqueProfessorDTOFromJson(Map json) =>
    PedidoSaqueProfessorDTO(
      idProfessor: json['idProfessor'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      consultasAReceber: (json['consultasAReceber'] as List<dynamic>)
          .map((e) =>
              ConsultaAReceberDTO.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      dataPedido: json['dataPedido'] as int,
    );

Map<String, dynamic> _$PedidoSaqueProfessorDTOToJson(
        PedidoSaqueProfessorDTO instance) =>
    <String, dynamic>{
      'idProfessor': instance.idProfessor,
      'email': instance.email,
      'telefone': instance.telefone,
      'consultasAReceber':
          instance.consultasAReceber.map((e) => e.toJson()).toList(),
      'dataPedido': instance.dataPedido,
    };
