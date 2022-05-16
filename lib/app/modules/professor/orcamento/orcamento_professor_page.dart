import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/orcamento/orcamento_professor_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrcamentoProfessorPage extends StatefulWidget {
  final ConsultaViewModel consulta;

  const OrcamentoProfessorPage(this.consulta, {Key? key}) : super(key: key);

  @override
  State<OrcamentoProfessorPage> createState() => _OrcamentoProfessorPageState();
}

class _OrcamentoProfessorPageState
    extends ModularState<OrcamentoProfessorPage, OrcamentoProfessorStore> {
  @override
  void initState() {
    super.initState();
    controller.consulta = widget.consulta;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map<String, dynamic> _buildDetails() {
    List<dynamic> listTipos = [];
    final Map<String?, dynamic>? _tipoArquivoResposta =
        widget.consulta.tipoArquivoResposta;

    if (_tipoArquivoResposta!.containsValue(true)) {
      listTipos.add(_tipoArquivoResposta.entries.where((e) => e.value == true));
    }

    var newListTipos = listTipos
        .toString()
        .replaceAll('[(MapEntry(', '')
        .replaceAll(': true', '')
        .replaceAll('MapEntry(', '')
        .replaceAll(')', '')
        .replaceAll('(', '')
        .replaceAll('))]', '')
        .replaceAll(']', '')
        .replaceAll(']', '');

    return {
      'Matéria': widget.consulta.nomeMateria,
      'Data': widget.consulta.dataInicio,
      'Hora': widget.consulta.hora,
      'Valor da consulta': widget.consulta.valor,
      'Observações': widget.consulta.obs,
      'Software de resposta': widget.consulta.softwareResposta!.isEmpty
          ? 'Não informado'
          : widget.consulta.softwareResposta,
      'Valores Especificos': widget.consulta.valEspecifico!.isEmpty
          ? 'Não informado'
          : widget.consulta.valEspecifico,
      'Tipos de arquivos resposta': widget.consulta.tipoArquivoResposta!.isEmpty
          ? 'Não informado'
          : newListTipos,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isScrollable: true,
      title: 'Orçamento ${widget.consulta.idNumerico}',
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Lembrando que ao orçar a atividade, torna-se um possível responsável pela mesma,'
            'não podendo desistir dela caso seu orçamento seja escolhido.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 18,
          ),
          _buildSectionHeader('Informações'),
          const SizedBox(
            height: 12,
          ),
          ..._buildDetails()
              .entries
              .map((detail) => _buildDetailItem(detail))
              .toList(),
          const SizedBox(
            height: 12,
          ),
          _buildValorPagoField(),
          const SizedBox(
            height: 12,
          ),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildDetailItem(MapEntry<String, dynamic> e) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(e.key, style: const TextStyle(color: AppColors.grey)),
          trailing: Text(
            e.value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.lightGrey,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Icon(MdiIcons.circle, size: 8),
          const SizedBox(width: 12),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 12,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValorPagoField() {
    bool isFirst = true;

    return CustomTextField(
      label: 'Valor Orçamento',
      controller: controller.ctrlValorProfessor,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {},
      keyboardType: TextInputType.number,
      suffixIcon: const Icon(Icons.monetization_on),
      maskFormatter: FilteringTextInputFormatter.digitsOnly,
      onChanged: (value) {
        final newValue = value.replaceAll(',', '').replaceAll('.', '');
        if (value.isEmpty || newValue == '00') {
          controller.ctrlValorProfessor.clear();
          isFirst = true;
          return;
        }
        double parsedValue = double.parse(newValue);
        if (!isFirst) parsedValue *= 100;
        final formattedValue = NumberFormat.currency(
          customPattern: 'R\$ ###,###.##',
        ).format(parsedValue / 100);
        controller.ctrlValorProfessor.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Observer(
      builder: (_) => CustomLoadButton(
        title: 'Enviar Orçamento',
        loading: controller.loading,
        onPressed: () {
          if (controller.ctrlValorProfessor.text.isEmpty) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: const Text(
                  'Falha ao realizar orçamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  'O orçamento deve ter um valor',
                  style: TextStyle(fontSize: 14),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          } else {
            controller.saveOrcamento();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const AlertDialog(
                title: Text(
                  'Realizando Orçamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Aguarde enquanto o processo de orçamento termina',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
