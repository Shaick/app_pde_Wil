import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/bad_message.dart';

part 'bad_message_dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class BadMessageDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'IDChat')
  final String idChat;
  @JsonKey(name: 'IDNumerico')
  final int idNumerico;
  @JsonKey(name: 'sentby_id')
  final String idRemetente;

  @JsonKey(name: 'badWord')
  final String textoCru;
  @JsonKey(name: 'lettering')
  final String texto;
  final bool desconsiderar;
  @JsonKey(name: 'numberCount')
  final int? contagemNumeros;
  final bool temNumero;
  final int timestamp;

  const BadMessageDTO({
    this.id,
    required this.idChat,
    required this.idNumerico,
    required this.idRemetente,
    required this.textoCru,
    required this.texto,
    required this.desconsiderar,
    this.contagemNumeros,
    required this.temNumero,
    required this.timestamp,
  });

  factory BadMessageDTO.fromJson(Map<String, dynamic> json) =>
      _$BadMessageDTOFromJson(json);
  Map<String, dynamic> toJson() => _$BadMessageDTOToJson(this);

  BadMessage toDomain() => BadMessage(
        id: id ?? '',
        idChat: idChat,
        idNumerico: idNumerico.toString(),
        idRemetente: idRemetente,
        textoCru: textoCru,
        texto: texto,
        desconsiderar: desconsiderar,
        temNumero: temNumero,
        timestamp: DateTime.fromMicrosecondsSinceEpoch(timestamp),
      );
  factory BadMessageDTO.fromDomain(BadMessage model) => BadMessageDTO(
        idChat: model.idChat,
        idNumerico: int.parse(model.idNumerico),
        idRemetente: model.idRemetente,
        textoCru: model.textoCru,
        texto: model.texto,
        desconsiderar: false,
        temNumero: model.temNumero,
        timestamp: model.timestamp.millisecondsSinceEpoch,
      );

  BadMessageDTO copyWith({
    String? id,
    String? idChat,
    int? idNumerico,
    String? idRemetente,
    String? textoCru,
    String? texto,
    bool? desconsiderar,
    int? contagemNumeros,
    bool? temNumero,
    int? timestamp,
  }) {
    return BadMessageDTO(
      id: id ?? this.id,
      idChat: idChat ?? this.idChat,
      idNumerico: idNumerico ?? this.idNumerico,
      idRemetente: idRemetente ?? this.idRemetente,
      textoCru: textoCru ?? this.textoCru,
      texto: texto ?? this.texto,
      desconsiderar: desconsiderar ?? this.desconsiderar,
      contagemNumeros: contagemNumeros ?? this.contagemNumeros,
      temNumero: temNumero ?? this.temNumero,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
