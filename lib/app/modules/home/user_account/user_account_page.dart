import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/modules/home/user_account/widget/user_bank_data.dart';
import 'package:app_pde/app/modules/home/user_account/widget/user_personal_data.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState
    extends ModularState<UserAccountPage, UserAccountStore> {
  @override
  void initState() {
    super.initState();
    controller.setUser();
    controller.user;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Minha conta',
      store: controller,
      hasDrawer: true,
      onWillPop: true,
      goHome: false,
      navigateHome: controller.pushome,
      actions: [
        IconButton(
          onPressed: () {
            controller.initUserEditPage();
            controller.pushEditPage();
          },
          icon: const Icon(MdiIcons.borderColor),
        ),
      ],
      body: Column(
        children: const [
          SizedBox(height: 24),
          UserPersonalData(),
          SizedBox(height: 48),
          UserBankData(),
        ],
      ),
    );
  }
}
