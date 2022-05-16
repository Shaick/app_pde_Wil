import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:app_pde/app/shared/widgets/custom_info_map_item.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../user_account_store.dart';

class UserPersonalData extends StatefulWidget {
  const UserPersonalData({Key? key}) : super(key: key);

  @override
  _UserPersonalDataState createState() => _UserPersonalDataState();
}

class _UserPersonalDataState
    extends ModularState<UserPersonalData, UserAccountStore> {
  @override
  void initState() {
    super.initState();
    controller.setUser();
    controller.user;
  }

  Map<String, String> _buildDetails() {
    final user = controller.user!;
    return {
      'Nome': user.apelido ?? 'Não informado',
      'E-mail': user.email,
      'Telefone': user.telefone,
      'CPF': user.cpf ?? 'Não informado',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          const PageSectionHeader('Dados pessoais'),
          const SizedBox(height: 12),
          ..._buildDetails().entries.map((e) => _buildDetailItem(e)).toList()
        ],
      ),
    );
  }

  Widget _buildDetailItem(MapEntry<String, String> e) {
    return Column(
      children: [
        CustomInfoMapItem(e),
        const CustomDivider(),
      ],
    );
  }
}
