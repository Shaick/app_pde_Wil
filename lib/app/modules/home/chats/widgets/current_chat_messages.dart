import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/modules/home/chats/view_models/mensagem_view_model.dart';
import 'package:app_pde/app/shared/widgets/custom_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'message_balloon.dart';

class CurrentChatMessages extends StatefulWidget {
  const CurrentChatMessages({Key? key}) : super(key: key);

  @override
  _CurrentChatMessagesState createState() => _CurrentChatMessagesState();
}

class _CurrentChatMessagesState
    extends ModularState<CurrentChatMessages, CurrentChatStore> {
  @override
  void initState() {
    controller.currentChat.mensagens;
    controller.watchChatMessages();
    controller.downloadedFilesPaths;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => CustomStreamBuilder<List<MensagemViewModel>>(
        stream: controller.onNewMessage,
        onSuccess: (messages) {
          controller.markMessagesAsRead();
          return _buildMessages(messages);
        },
        onError: () => const Center(child: Text('Erro ao carregar mensagens')),
      ),
    );
  }

  Widget _buildMessages(List<MensagemViewModel> messages) {
    return ListView.builder(
      key: const PageStorageKey('controllerA'),
      physics: const BouncingScrollPhysics(),
      reverse: true,
      itemBuilder: (context, index) => MessageBalloon(messages[index]),
      itemCount: messages.length,
    );
  }
}
