// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulta_a_receber_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsultaAReceberDTO _$ConsultaAReceberDTOFromJson(Map json) =>
    ConsultaAReceberDTO(
      idConsulta: json['idConsulta'] as String,
      idMateria: json['idMateria'] as String,
      valorProfessor: (json['valorProfessor'] as num).toDouble(),
    );

Map<String, dynamic> _$ConsultaAReceberDTOToJson(
        ConsultaAReceberDTO instance) =>
    <String, dynamic>{
      'idConsulta': instance.idConsulta,
      'idMateria': instance.idMateria,
      'valorProfessor': instance.valorProfessor,
    };
