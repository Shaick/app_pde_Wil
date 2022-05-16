import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:app_pde/app/shared/widgets/custom_info_map_item.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserBankData extends StatefulWidget {
  const UserBankData({Key? key}) : super(key: key);

  @override
  _UserBankDataState createState() => _UserBankDataState();
}

class _UserBankDataState extends ModularState<UserBankData, UserAccountStore> {
  Map<String, String> _buildDetails() {
    final user = controller.user!;
    return {
      'Banco': user.banco ?? 'Não informado',
      'Agência': user.agenciaBanco ?? 'Não informado',
      'Conta': user.contaBanco ?? 'Não informado',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          const PageSectionHeader('Dados bancários'),
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
