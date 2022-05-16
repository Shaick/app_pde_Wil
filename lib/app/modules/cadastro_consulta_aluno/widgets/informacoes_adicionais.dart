import 'package:app_pde/app/models/checkbox_model.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/checkbox_page.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cadastro_consulta_aluno_store.dart';

class InformacoesAdicionais extends StatefulWidget {
  const InformacoesAdicionais({Key? key}) : super(key: key);

  @override
  _InformacoesAdicionaisState createState() => _InformacoesAdicionaisState();
}

class _InformacoesAdicionaisState
    extends ModularState<InformacoesAdicionais, CadastroConsultaAlunoStore> {
  final List<CheckBoxModel> itensAtividade = [
    CheckBoxModel(texto: "Feito a mão com foto digitalizada"),
    CheckBoxModel(texto: "PDF"),
    CheckBoxModel(texto: "DWG"),
    CheckBoxModel(texto: "XLSX"),
    CheckBoxModel(texto: "DOCX"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageSectionHeader("Informações Adicionais"),
        const SizedBox(height: 12),
        _buildText("Formato de Resposta"),
        const SizedBox(height: 12),
        ...itensAtividade.map((e) => CheckboxPage(item: e)).toList(),
        const SizedBox(height: 18),
        _buildText("Necessidade de utilização de software para a resolução?"),
        const SizedBox(height: 18),
        _buildTextSoftwareResposta(),
        const SizedBox(height: 48),
        _buildText("Existe algum valor específico para essa consulta?"),
        const SizedBox(height: 10),
        _buildValoresEspecif(),
      ],
    );
  }

  Widget _buildText(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextSoftwareResposta() {
    return CustomTextField(
      validator: (value) => controller.validaSoftwareResposta(value),
      controller: controller.ctrlSoftwareResposta,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      label: 'AutoCAD, Matlab...',
      maxLines: null,
      suffixIcon: const Icon(Icons.widgets_sharp),
    );
  }

  Widget _buildValoresEspecif() {
    return CustomTextField(
      validator: (_) => controller.validaNull(),
      controller: controller.ctrlValorEspecifico,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      label: 'Número de Matrícula, RA, g = 10 ...',
      maxLines: null,
    );
  }
}
