import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageTextField extends StatefulWidget {
  final bool isEnabled;

  const MessageTextField({Key? key, required this.isEnabled}) : super(key: key);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState
    extends ModularState<MessageTextField, CurrentChatStore> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            TextFormField(
              maxLines: null,
              enabled: widget.isEnabled,
              controller: controller.messageController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.isEnabled
                    ? 'Escreva sua mensagem...'
                    : 'Esta conversa foi finalizada',
                filled: true,
                fillColor: AppColors.lightGrey,
                suffixIcon: IconButton(
                  onPressed: controller.toggleAttachmentCard,
                  color: AppColors.grey,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(MdiIcons.attachment),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
