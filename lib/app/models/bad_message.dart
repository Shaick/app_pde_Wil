import 'package:app_pde/app/modules/home/chats/view_models/chat_view_model.dart';
import 'package:equatable/equatable.dart';

import 'filtered_message.dart';

class BadMessage extends Equatable {
  final String id;
  final String idChat;
  final String idNumerico;
  final String idRemetente;

  final String textoCru;
  final String texto;
  final bool desconsiderar;
  final int? contagemNumeros;
  final bool temNumero;
  final DateTime timestamp;

  const BadMessage({
    required this.id,
    required this.idChat,
    required this.idNumerico,
    required this.idRemetente,
    required this.textoCru,
    required this.texto,
    required this.desconsiderar,
    this.contagemNumeros,
    required this.temNumero,
    required this.timestamp,
  }) : assert(temNumero == (contagemNumeros != null));

  factory BadMessage.fromFilteredMessage({
    required FilteredMessage filteredMessage,
    required String senderId,
    required String messageId,
    required ChatViewModel chat,
  }) {
    return BadMessage(
      id: messageId,
      idChat: chat.id,
      idNumerico: chat.idNumerico,
      idRemetente: senderId,
      textoCru: filteredMessage.rawText,
      texto: filteredMessage.text,
      desconsiderar: false,
      temNumero: filteredMessage.hasNumber,
      timestamp: filteredMessage.timeMessage,
      contagemNumeros:
          filteredMessage.numberCount == 0 ? null : filteredMessage.numberCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        idChat,
        idNumerico,
        idRemetente,
        textoCru,
        texto,
        desconsiderar,
        contagemNumeros,
        temNumero,
        timestamp,
      ];
}
