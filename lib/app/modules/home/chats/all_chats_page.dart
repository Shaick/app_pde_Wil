import 'package:app_pde/app/modules/home/chats/all_chats_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_list_tile.dart';
import 'package:app_pde/app/shared/widgets/leading_rounded_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({Key? key}) : super(key: key);

  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends ModularState<AllChatsPage, AllChatsStore> {
  @override
  void initState() {
    super.initState();
    controller.fetchNecessaryData();
    controller.fetchUserChats();
    controller.getDownloadedFiles();
    controller.downloadedFilesPaths;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Mensagens',
      hasDrawer: true,
      isScrollable: false,
      goHome: false,
      navigateHome: controller.pushome,
      body: Observer(
        builder: (_) => controller.loading
            ? const Center(child: CircularProgressIndicator())
            : _buildChatsDisplay(),
      ),
    );
  }

  Widget _buildChatsDisplay() {
    return controller.chats.isEmpty
        ? const Center(
            child: Text(
              'Nenhuma mensagem por aqui',
              style: TextStyle(color: AppColors.grey),
            ),
          )
        : _buildChatList();
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: controller.chats.length,
      itemBuilder: (context, index) {
        final chat = controller.chats[index];
        return CustomListTile(
          title: chat.nomeMateria,
          subtitle: chat.ultimaMensagem?.texto,
          icon: Container(),
          leading: LeadingRoundedBox(
            text: chat.idNumerico,
            color: chat.color,
          ),
          trailing: const Icon(
            MdiIcons.chevronRight,
          ),
          onTap: () => controller.pushChatPage(chat),
        );
      },
    );
  }
}
