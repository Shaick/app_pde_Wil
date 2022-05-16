import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/arquivo.dart';

part 'arquivo_dto.g.dart';

@JsonSerializable(anyMap: true)
class ArquivoDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'Nome')
  final String nome;
  @JsonKey(name: 'Url')
  final String downloadUrl;
  @JsonKey(name: 'FullPath')
  final String storagePath;
  @JsonKey(name: 'Data')
  final int timestamp;
  @JsonKey(name: 'Tipo')
  final String? fileExtension;
  @JsonKey(name: 'Tamanho')
  final int? size;

  const ArquivoDTO({
    this.id,
    required this.nome,
    required this.downloadUrl,
    required this.storagePath,
    required this.timestamp,
    this.fileExtension,
    this.size,
  });

  factory ArquivoDTO.fromJson(Map json) => _$ArquivoDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ArquivoDTOToJson(this);

  Arquivo toDomain() {
    return Arquivo(
      id: id ?? '',
      nome: nome,
      displayName: nome,
      size: size,
      downloadUrl: downloadUrl,
      fileExtension: fileExtension,
      storagePath: storagePath,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  factory ArquivoDTO.fromDomain(Arquivo model) {
    return ArquivoDTO(
      id: model.id,
      nome: model.displayName,
      downloadUrl: model.downloadUrl ?? '',
      storagePath: model.storagePath,
      timestamp: model.timestamp.millisecondsSinceEpoch,
      fileExtension: model.fileExtension,
      size: model.size,
    );
  }

  ArquivoDTO copyWith({
    String? id,
    String? nome,
    String? downloadUrl,
    String? storagePath,
    int? timestamp,
    String? fileExtension,
    int? size,
  }) {
    return ArquivoDTO(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      storagePath: storagePath ?? this.storagePath,
      timestamp: timestamp ?? this.timestamp,
      fileExtension: fileExtension ?? this.fileExtension,
      size: size ?? this.size,
    );
  }
}
