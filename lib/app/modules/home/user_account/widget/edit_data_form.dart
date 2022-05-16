import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/shared/utlis/mask_map.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditDataForm extends StatelessWidget {
  final UserAccountStore controller;

  const EditDataForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const PageSectionHeader('Dados pessoais'),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Nome',
            hint: 'Digite seu nome',
            controller: controller.ctrlApelido,
            keyboardType: TextInputType.name,
            validator: controller.validaApelido,
          ),
          CustomTextField(
            controller: controller.ctrlCpf,
            validator: controller.validaCpf,
            label: 'CPF',
            hint: 'Digite seu CPF',
            enabled: false,
            maskFormatter: masks['cpf'],
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            label: 'Telefone',
            hint: '+XX (XX) XXXXX-XXXX',
            enabled: false,
            controller: controller.ctrlTelefone,
            validator: controller.validaTelefone,
            maskFormatter: masks['cel'],
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 48),
          const PageSectionHeader('Dados bancários'),
          const SizedBox(height: 12),
          CustomTextField(
            controller: controller.ctrlBanco,
            validator: controller.validaBanco,
            label: 'Banco',
            hint: 'Digite o banco',
          ),
          CustomTextField(
            controller: controller.ctrlAgenciaBanco,
            validator: controller.validaAgencia,
            label: 'Agência',
            hint: 'Digite sua agência',
          ),
          CustomTextField(
            controller: controller.ctrlContaBanco,
            validator: controller.validaConta,
            label: 'Conta',
            hint: 'Digite sua conta',
          ),
          const SizedBox(height: 24),
          Observer(
            builder: (context) => CustomLoadButton(
              title: 'Salvar',
              loading: controller.loading,
              onPressed: controller.updateUserData,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
