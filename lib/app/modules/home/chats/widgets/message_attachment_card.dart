import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/modules/home/chats/widgets/attachment_dialog.dart';
import 'package:app_pde/app/modules/home/chats/widgets/bordered_attachment_box.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageAttachmentCard extends StatefulWidget {
  const MessageAttachmentCard({Key? key}) : super(key: key);

  @override
  _MessageAttachmentCardState createState() => _MessageAttachmentCardState();
}

class _MessageAttachmentCardState
    extends ModularState<MessageAttachmentCard, CurrentChatStore>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    controller.registerAnimationController(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: SizeTransition(
        sizeFactor: controller.animation,
        axisAlignment: -1.0,
        child: FadeTransition(
          opacity: controller.animation,
          child: _buildAttachmentCard(),
        ),
      ),
    );
  }

  Widget _buildAttachmentCard() {
    return CustomCard(
      elevation: 6,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionCard(
            labelText: 'Tirar uma foto',
            icon: MdiIcons.cameraOutline,
            onTap: () {
              controller.takePicture().then((_) => controller.sendMessage());
            },
          ),
          const SizedBox(width: 16),
          _buildActionCard(
            labelText: 'Escolher um arquivo',
            icon: MdiIcons.fileOutline,
            onTap: () {
              controller.pickFiles().then((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AttachmentDialog(
                    controller: controller,
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String labelText,
    required IconData icon,
    required Function onTap,
  }) {
    return BorderedAttachmentBox(
      labelText: labelText,
      icon: icon,
      onTap: () {
        controller.dismissKeyboard(context);
        onTap();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.disposeController();
  }
}
