// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioDTO _$UsuarioDTOFromJson(Map<String, dynamic> json) => UsuarioDTO(
      email: json['Email'] as String,
      idPermissao: json['IDPermissao'],
      telefone: json['Telefone'] as String,
      materias: (json['Materias'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      apelido: json['Apelido'] as String?,
      agenciaBanco: json['AgenciaBanco'] as String?,
      contaBanco: json['ContaBanco'] as String?,
      banco: json['Banco'] as String?,
      cpf: json['CPF'] as String?,
    );

Map<String, dynamic> _$UsuarioDTOToJson(UsuarioDTO instance) =>
    <String, dynamic>{
      'Email': instance.email,
      'IDPermissao': instance.idPermissao,
      'Telefone': instance.telefone,
      'Apelido': instance.apelido,
      'Materias': instance.materias,
      'AgenciaBanco': instance.agenciaBanco,
      'ContaBanco': instance.contaBanco,
      'Banco': instance.banco,
      'CPF': instance.cpf,
    };
