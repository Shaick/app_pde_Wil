import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/chat.dart';

import 'mensagem_dto.dart';

part 'chat_dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ChatDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'IDProfessor')
  final String idProfessor;
  @JsonKey(name: 'IDAluno')
  final String idAluno;
  @JsonKey(name: 'IDMateria')
  final String idMateria;
  @JsonKey(name: 'IDNumerico')
  final int idNumerico;
  @JsonKey(name: 'closed', defaultValue: false)
  final bool concluido;
  @JsonKey(name: 'messages', fromJson: convertMensagensToJson)
  final List<MensagemDTO>? mensagens;

  const ChatDTO({
    this.id,
    required this.idProfessor,
    required this.idAluno,
    required this.idMateria,
    required this.idNumerico,
    required this.concluido,
    this.mensagens,
  });

  static List<MensagemDTO> convertMensagensToJson(Map? json) {
    if (json == null) return [];
    return json.entries
        .map((e) => MensagemDTO.fromJson(e.value).copyWith(id: e.key))
        .toList();
  }

  factory ChatDTO.fromJson(Map json) => _$ChatDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ChatDTOToJson(this);

  Chat toDomain() => Chat(
        id: id ?? '',
        idProfessor: idProfessor,
        idAluno: idAluno,
        idMateria: idMateria,
        idNumerico: idNumerico.toString(),
        concluido: concluido,
        mensagens: mensagens?.map((e) => e.toDomain()).toList() ?? [],
      );

  factory ChatDTO.fromDomain(Chat model) => ChatDTO(
        idProfessor: model.idProfessor,
        idAluno: model.idAluno,
        idMateria: model.idMateria,
        idNumerico: int.parse(model.idNumerico),
        concluido: model.concluido,
        mensagens:
            model.mensagens.map((e) => MensagemDTO.fromDomain(e)).toList(),
      );

  ChatDTO copyWith({
    String? id,
    String? idProfessor,
    String? idAluno,
    String? idMateria,
    int? idNumerico,
    bool? concluido,
    List<MensagemDTO>? mensagens,
  }) {
    return ChatDTO(
      id: id ?? this.id,
      idProfessor: idProfessor ?? this.idProfessor,
      idAluno: idAluno ?? this.idAluno,
      idMateria: idMateria ?? this.idMateria,
      idNumerico: idNumerico ?? this.idNumerico,
      concluido: concluido ?? this.concluido,
      mensagens: mensagens ?? this.mensagens,
    );
  }
}
