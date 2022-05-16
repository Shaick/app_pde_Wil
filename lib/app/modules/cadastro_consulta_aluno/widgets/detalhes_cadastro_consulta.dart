// ignore_for_file: body_might_complete_normally_nullable

import 'package:app_pde/app/models/checkbox_model.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/cadastro_consulta_aluno_store.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/checkbox_orcamento.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class DetalhesCadastroConsulta extends StatefulWidget {
  const DetalhesCadastroConsulta({Key? key}) : super(key: key);

  @override
  _DetalhesCadastroConsultaState createState() =>
      _DetalhesCadastroConsultaState();
}

class _DetalhesCadastroConsultaState
    extends ModularState<DetalhesCadastroConsulta, CadastroConsultaAlunoStore> {
  final List<CheckBoxModel> pedidoOrcamento = [
    CheckBoxModel(texto: "Quero um Orçamento"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageSectionHeader('Detalhes'),
        const SizedBox(height: 12),
        _buildMateriaDropdownField(),
        const SizedBox(height: 12),
        _buildObservationsField(),
        const SizedBox(height: 12),
        _buildValorPagoField(),
        const SizedBox(
          height: 12,
        ),
        ...pedidoOrcamento.map((e) => CheckboxOrcamentoPage(item: e)).toList(),
      ],
    );
  }

  Widget _buildMateriaDropdownField() {
    return Observer(
      builder: (_) => DropdownButtonFormField<String>(
        isExpanded: true,
        hint: const Text("Matéria *"),
        value: controller.ctrlMateria.text.isEmpty
            ? null
            : controller.ctrlMateria.text,
        onChanged: (newValue) => controller.ctrlMateria.text = newValue!,
        validator: (value) {
          return value == null ? 'Escolha a matéria da sua consulta.' : null;
        },
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.library_books_outlined),
        ),
        items: controller.materias
            .map((materia) => DropdownMenuItem<String>(
                  value: materia.id,
                  onTap: () =>
                      controller.ctrlNomeMateria.text = materia.nome ?? '',
                  child: Text(materia.nome ?? ''),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildObservationsField() {
    return CustomTextField(
      validator: (value) => controller.validaObs(value),
      controller: controller.ctrlObservacoes,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      label: 'Observações *',
      maxLines: null,
      suffixIcon: const Icon(
        Icons.view_list_rounded,
        color: AppColors.grey,
      ),
    );
  }

  Widget _buildValorPagoField() {
    bool isFirst = true;

    return Observer(
      builder: (_) => CustomTextField(
        label: 'Valor pago',
        controller: controller.isOrcamento ? null : controller.ctrlValorPago,
        validator: (value) {},
        enabled: controller.isOrcamento ? false : true,
        keyboardType: TextInputType.number,
        suffixIcon: const Icon(
          Icons.monetization_on,
          color: AppColors.grey,
        ),
        maskFormatter: FilteringTextInputFormatter.digitsOnly,
        onChanged: (value) {
          final newValue = value.replaceAll(',', '').replaceAll('.', '');
          if (value.isEmpty || newValue == '00') {
            controller.ctrlValorPago.clear();
            isFirst = true;
            return;
          }
          double parsedValue = double.parse(newValue);
          if (!isFirst) parsedValue *= 100;
          final formattedValue = NumberFormat.currency(
            customPattern: 'R\$ ###,###.##',
          ).format(parsedValue / 100);
          controller.ctrlValorPago.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );
        },
      ),
    );
  }
}
