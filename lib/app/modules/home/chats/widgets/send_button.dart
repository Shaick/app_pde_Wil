import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../current_chat_store.dart';

class SendButton extends StatefulWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  _SendButtonState createState() => _SendButtonState();
}

class _SendButtonState extends ModularState<SendButton, CurrentChatStore> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: AppColors.primary,
      child: InkWell(
        onTap: controller.sendMessage,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(MdiIcons.send, color: Colors.white),
        ),
      ),
    );
  }
}
