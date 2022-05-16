import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/modules/home/user_account/widget/edit_data_form.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<UserAccountStore>();
    return AppScaffold(
      title: 'Editar dados',
      actions: [
        IconButton(
          onPressed: controller.updateUserData,
          icon: const Icon(MdiIcons.contentSave),
        ),
      ],
      isScrollable: true,
      body: EditDataForm(controller: controller),
    );
  }
}
