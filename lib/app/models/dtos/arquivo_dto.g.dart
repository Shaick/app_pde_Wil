// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arquivo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArquivoDTO _$ArquivoDTOFromJson(Map json) => ArquivoDTO(
      nome: json['Nome'] as String,
      downloadUrl: json['Url'] as String,
      storagePath: json['FullPath'] as String,
      timestamp: json['Data'] as int,
      fileExtension: json['Tipo'] as String?,
      size: json['Tamanho'] as int?,
    );

Map<String, dynamic> _$ArquivoDTOToJson(ArquivoDTO instance) =>
    <String, dynamic>{
      'Nome': instance.nome,
      'Url': instance.downloadUrl,
      'FullPath': instance.storagePath,
      'Data': instance.timestamp,
      'Tipo': instance.fileExtension,
      'Tamanho': instance.size,
    };
