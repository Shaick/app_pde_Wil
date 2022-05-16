// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orcamento_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrcamentoDTO _$OrcamentoDTOFromJson(Map json) => OrcamentoDTO(
      idProfessor: json['IDProfessor'] as String,
      nomeFantasia: json['NomeFantasia'] as String?,
      escolhido: json['Escolhido'] as bool?,
      alunoJaViuOrcamento: json['AlunoJaViuOrcamento'] as bool?,
      valorConsulta: (json['ValorConsulta'] as num?)?.toDouble(),
      valorProfessor: (json['ValorProfessor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrcamentoDTOToJson(OrcamentoDTO instance) =>
    <String, dynamic>{
      'IDProfessor': instance.idProfessor,
      'NomeFantasia': instance.nomeFantasia,
      'Escolhido': instance.escolhido,
      'AlunoJaViuOrcamento': instance.alunoJaViuOrcamento,
      'ValorConsulta': instance.valorConsulta,
      'ValorProfessor': instance.valorProfessor,
    };
