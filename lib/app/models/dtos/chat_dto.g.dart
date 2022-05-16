// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDTO _$ChatDTOFromJson(Map json) => ChatDTO(
      idProfessor: json['IDProfessor'] as String,
      idAluno: json['IDAluno'] as String,
      idMateria: json['IDMateria'] as String,
      idNumerico: json['IDNumerico'] as int,
      concluido: json['closed'] as bool? ?? false,
      mensagens: ChatDTO.convertMensagensToJson(json['messages'] as Map?),
    );

Map<String, dynamic> _$ChatDTOToJson(ChatDTO instance) => <String, dynamic>{
      'IDProfessor': instance.idProfessor,
      'IDAluno': instance.idAluno,
      'IDMateria': instance.idMateria,
      'IDNumerico': instance.idNumerico,
      'closed': instance.concluido,
      'messages': instance.mensagens?.map((e) => e.toJson()).toList(),
    };
