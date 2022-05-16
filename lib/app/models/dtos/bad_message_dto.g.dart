// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bad_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadMessageDTO _$BadMessageDTOFromJson(Map json) => BadMessageDTO(
      idChat: json['IDChat'] as String,
      idNumerico: json['IDNumerico'] as int,
      idRemetente: json['sentby_id'] as String,
      textoCru: json['badWord'] as String,
      texto: json['lettering'] as String,
      desconsiderar: json['desconsiderar'] as bool,
      contagemNumeros: json['numberCount'] as int?,
      temNumero: json['temNumero'] as bool,
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$BadMessageDTOToJson(BadMessageDTO instance) =>
    <String, dynamic>{
      'IDChat': instance.idChat,
      'IDNumerico': instance.idNumerico,
      'sentby_id': instance.idRemetente,
      'badWord': instance.textoCru,
      'lettering': instance.texto,
      'desconsiderar': instance.desconsiderar,
      'numberCount': instance.contagemNumeros,
      'temNumero': instance.temNumero,
      'timestamp': instance.timestamp,
    };
