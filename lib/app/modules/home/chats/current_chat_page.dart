import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/modules/home/chats/view_models/chat_view_model.dart';
import 'package:app_pde/app/modules/home/chats/widgets/current_chat_messages.dart';
import 'package:app_pde/app/modules/home/chats/widgets/message_text_field.dart';
import 'package:app_pde/app/modules/home/chats/widgets/send_button.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/message_attachment_card.dart';

class CurrentChatPage extends StatefulWidget {
  final ChatViewModel chat;

  const CurrentChatPage(this.chat, {Key? key}) : super(key: key);

  @override
  _CurrentChatPageState createState() => _CurrentChatPageState();
}

class _CurrentChatPageState
    extends ModularState<CurrentChatPage, CurrentChatStore> {
  @override
  void initState() {
    super.initState();
    controller.initialize(widget.chat);
    controller.currentChat.mensagens;
    controller.getDownloadedFilesPaths();
    controller.downloadedFilesPaths;
  }

  @override
  Widget build(BuildContext context) {
    final chat = widget.chat;
    return AppScaffold(
      title: '#${chat.idNumerico} - ${chat.nomeMateria}',
      isScrollable: false,
      store: controller,
      body: GestureDetector(
        onTap: () {
          controller.toggleAttachmentCard(chatPage: true);
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const CurrentChatMessages(),
                  const MessageAttachmentCard(),
                ],
              ),
            ),
            const SizedBox(height: 6),
            _buildMessageInput(),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(child: MessageTextField(isEnabled: !widget.chat.concluido)),
        const SizedBox(width: 16),
        const SendButton(),
      ],
    );
  }
}
