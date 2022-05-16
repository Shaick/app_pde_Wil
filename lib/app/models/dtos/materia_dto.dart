import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/materia.dart';

part 'materia_dto.g.dart';

@JsonSerializable()
class MateriaDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'Nome')
  final String? nome;
  @JsonKey(name: 'Sigla')
  final String? sigla;
  @JsonKey(name: 'Description')
  final String? descricao;
  @JsonKey(name: 'CategoriaBase')
  final int? categoria;
  final String? idGrupo;
  final double? valorBaseProfessor;

  const MateriaDTO({
    this.id,
    this.nome,
    this.sigla,
    this.descricao,
    required this.categoria,
    this.idGrupo,
    this.valorBaseProfessor,
  });

  factory MateriaDTO.fromJson(Map<String, dynamic> json) =>
      _$MateriaDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MateriaDTOToJson(this);

  factory MateriaDTO.fromDomain(Materia model) => MateriaDTO(
        id: model.id,
        nome: model.nome,
        categoria: model.categoria,
        descricao: model.descricao,
        idGrupo: model.idGrupo,
        sigla: model.sigla,
        valorBaseProfessor: model.valorBaseProfessor,
      );
  Materia toDomain() => Materia(
        id: id ?? '',
        sigla: sigla,
        nome: nome,
        descricao: descricao,
        categoria: categoria,
        idGrupo: idGrupo,
        valorBaseProfessor: valorBaseProfessor,
      );

  MateriaDTO copyWith({
    String? id,
    String? nome,
    String? sigla,
    String? descricao,
    int? categoria,
    String? idGrupo,
    double? valorBaseProfessor,
  }) {
    return MateriaDTO(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      sigla: sigla ?? this.sigla,
      descricao: descricao ?? this.descricao,
      categoria: categoria ?? this.categoria,
      idGrupo: idGrupo ?? this.idGrupo,
      valorBaseProfessor: valorBaseProfessor ?? this.valorBaseProfessor,
    );
  }
}
