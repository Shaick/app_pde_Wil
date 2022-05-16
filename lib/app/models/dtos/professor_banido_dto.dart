import 'package:json_annotation/json_annotation.dart';

import '../professor_banido.dart';

part 'professor_banido_dto.g.dart';

@JsonSerializable(anyMap: true)
class ProfessorBanidoDTO {
  final String? id;
  final bool banido;

  const ProfessorBanidoDTO({this.id, required this.banido});

  factory ProfessorBanidoDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfessorBanidoDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ProfessorBanidoDTOToJson(this);

  factory ProfessorBanidoDTO.fromDomain(ProfessorBanido domain) {
    return ProfessorBanidoDTO(
      id: domain.id,
      banido: domain.banido,
    );
  }

  ProfessorBanido toDomain() {
    return ProfessorBanido(
      id: this.id ?? '',
      banido: this.banido,
    );
  }

  ProfessorBanidoDTO copyWith({String? id, bool? banido}) {
    return ProfessorBanidoDTO(
      id: id ?? this.id!,
      banido: banido ?? this.banido,
    );
  }
}
