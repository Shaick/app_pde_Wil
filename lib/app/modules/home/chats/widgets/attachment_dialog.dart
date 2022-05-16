import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AttachmentDialog extends StatelessWidget {
  final CurrentChatStore controller;

  const AttachmentDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.defaultBorderRadius / 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          right: 24,
          left: 24,
          bottom: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Arquivos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            _buildPickedFilesList(context),
            _buildMessageField(),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPickedFilesList(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    return Observer(
      builder: (_) {
        return SizedBox(
          height: screenHeight / 6,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ...controller.pickedFiles
                  .map(
                    (file) => ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        file.fileName,
                        style: const TextStyle(color: AppColors.primaryDark),
                      ),
                      leading: Icon(
                        file.isImage
                            ? MdiIcons.imageOutline
                            : MdiIcons.fileOutline,
                        color: AppColors.primaryDark,
                      ),
                      trailing: IconButton(
                        onPressed: () => controller.removeFile(file),
                        icon: const Icon(
                          MdiIcons.close,
                          color: AppColors.error,
                        ),
                      ),
                      onTap: () {},
                    ),
                  )
                  .toList(),
              IconButton(
                onPressed: controller.pickFiles,
                icon: const Icon(
                  MdiIcons.plusCircleOutline,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageField() {
    return TextField(
      controller: controller.messageController,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      keyboardType: TextInputType.multiline,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: const Text(
            'CANCELAR',
            style: TextStyle(color: AppColors.error),
          ),
          onPressed: () {
            Modular.to.pop(false);
            controller.pickedFiles.clear();
          },
        ),
        const SizedBox(width: 8),
        TextButton(
            child: const Text(
              'ENVIAR',
              style: TextStyle(color: AppColors.primary),
            ),
            onPressed: () {
              controller.sendMessage();
              Modular.to.pop(true);
            })
      ],
    );
  }
}
