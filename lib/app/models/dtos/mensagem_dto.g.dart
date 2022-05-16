// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensagem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensagemDTO _$MensagemDTOFromJson(Map json) => MensagemDTO(
      idRemetente: json['sentby_id'] as String,
      texto: json['lettering'] as String,
      visto: json['readed'] as bool?,
      timestamp: json['timestamp'] as int,
      arquivos: (json['filesMD'] as List<dynamic>?)
          ?.map((e) => ArquivoDTO.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$MensagemDTOToJson(MensagemDTO instance) =>
    <String, dynamic>{
      'sentby_id': instance.idRemetente,
      'lettering': instance.texto,
      'readed': instance.visto,
      'timestamp': instance.timestamp,
      'filesMD': instance.arquivos?.map((e) => e.toJson()).toList(),
    };
