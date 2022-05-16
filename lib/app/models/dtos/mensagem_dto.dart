import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/dtos/arquivo_dto.dart';
import 'package:app_pde/app/models/mensagem.dart';

part 'mensagem_dto.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class MensagemDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'sentby_id')
  final String idRemetente;
  @JsonKey(name: 'lettering')
  final String texto;
  @JsonKey(name: 'readed')
  final bool? visto;
  int timestamp;
  @JsonKey(name: 'filesMD')
  final List<ArquivoDTO>? arquivos;

  MensagemDTO({
    this.id,
    required this.idRemetente,
    required this.texto,
    this.visto,
    required this.timestamp,
    this.arquivos,
  });

  factory MensagemDTO.fromJson(Map json) => _$MensagemDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MensagemDTOToJson(this);

  Mensagem toDomain() => Mensagem(
        id: id ?? '',
        idRemetente: idRemetente,
        texto: texto,
        visto: visto ?? false,
        timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
        arquivos: arquivos?.map((e) => e.toDomain()).toList(),
      );
  factory MensagemDTO.fromDomain(Mensagem model) => MensagemDTO(
        idRemetente: model.idRemetente,
        texto: model.texto,
        visto: model.visto,
        timestamp: model.timestamp.millisecondsSinceEpoch,
        arquivos: model.arquivos?.map((e) => ArquivoDTO.fromDomain(e)).toList(),
      );

  MensagemDTO copyWith({
    String? id,
    String? idRemetente,
    String? texto,
    bool? visto,
    int? timestamp,
    List<ArquivoDTO>? arquivos,
  }) {
    return MensagemDTO(
      id: id ?? this.id,
      idRemetente: idRemetente ?? this.idRemetente,
      texto: texto ?? this.texto,
      visto: visto ?? this.visto,
      timestamp: timestamp ?? this.timestamp,
      arquivos: arquivos ?? this.arquivos,
    );
  }
}
