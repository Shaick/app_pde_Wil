import 'dart:ui';

import 'package:app_pde/app/models/chat.dart';
import 'package:app_pde/app/models/mensagem.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';

import 'mensagem_view_model.dart';

class ChatViewModel {
  final String id;
  final String idNumerico;
  final bool concluido;
  final List<MensagemViewModel> mensagens;
  final String nomeMateria;
  final Mensagem? ultimaMensagem;
  final Color color;

  const ChatViewModel({
    required this.id,
    required this.idNumerico,
    required this.concluido,
    required this.mensagens,
    required this.nomeMateria,
    this.ultimaMensagem,
    required this.color,
  });

  factory ChatViewModel.fromDomain(Chat chat, {required String nomeMateria}) {
    return ChatViewModel(
      id: chat.id,
      idNumerico: chat.idNumerico,
      concluido: chat.concluido,
      mensagens: chat.mensagens
          .map(
            (e) => MensagemViewModel.fromDomain(e),
          )
          .toList(),
      nomeMateria: nomeMateria,
      ultimaMensagem: chat.isEmpty ? null : chat.mensagens.first,
      color: chat.concluido ? AppColors.primaryLight : AppColors.accent,
    );
  }
}
