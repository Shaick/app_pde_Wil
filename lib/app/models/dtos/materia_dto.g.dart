// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materia_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MateriaDTO _$MateriaDTOFromJson(Map<String, dynamic> json) => MateriaDTO(
      nome: json['Nome'] as String?,
      sigla: json['Sigla'] as String?,
      descricao: json['Description'] as String?,
      categoria: json['CategoriaBase'] as int?,
      idGrupo: json['idGrupo'] as String?,
      valorBaseProfessor: (json['valorBaseProfessor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MateriaDTOToJson(MateriaDTO instance) =>
    <String, dynamic>{
      'Nome': instance.nome,
      'Sigla': instance.sigla,
      'Description': instance.descricao,
      'CategoriaBase': instance.categoria,
      'idGrupo': instance.idGrupo,
      'valorBaseProfessor': instance.valorBaseProfessor,
    };
