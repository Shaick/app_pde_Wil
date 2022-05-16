import 'package:app_pde/app/modules/cadastro_consulta_aluno/cadastro_consulta_aluno_store.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/revisao_page/widgets/revisao_consulta_warning_card.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:app_pde/app/shared/widgets/custom_info_map_item.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class RevisaoConsultaPage extends StatefulWidget {
  const RevisaoConsultaPage({Key? key}) : super(key: key);

  @override
  _RevisaoConsultaPageState createState() => _RevisaoConsultaPageState();
}

class _RevisaoConsultaPageState extends State<RevisaoConsultaPage> {
  final controller = Modular.get<CadastroConsultaAlunoStore>();

  Map<String, dynamic> _buildDados() {
    String? formattedDate;
    String? formattedHour;

    final dateTime = DateTime.tryParse(controller.ctrlDataConsulta.text);
    if (dateTime != null) {
      formattedDate = DateFormat.MMMMd().format(dateTime);
    }
    if (controller.horaInicio != null) {
      formattedHour = DateFormat.Hm().format(controller.horaInicio!) +
          ' – ' +
          DateFormat.Hm().format(controller.horaFim!);
    }

    List<dynamic> listTipos = [];
    final Map<String?, dynamic>? _tipoArquivoResposta =
        controller.getTipoArquivoResposta();

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
      'Matéria': controller.ctrlNomeMateria.text,
      'Data': formattedDate ?? controller.ctrlDataConsulta.text,
      'Hora': formattedHour ?? controller.ctrlHoraInicio.text,
      'Valor da consulta': controller.ctrlValorPago.text.isEmpty
          ? "valor não informado"
          : controller.ctrlValorPago.text,
      'Software de resposta': controller.ctrlSoftwareResposta.text,
      'Valores Especificos': controller.ctrlValorEspecifico.text,
      'Tipos de arquivos resposta': newListTipos,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Confirmação de agendamento',
      hasDrawer: false,
      body: Column(
        children: [
          ..._buildDados()
              .entries
              .map((dado) => _buildConfirmarDados(dado))
              .toList(),
          _buildObservacoes(),
          const SizedBox(height: 24),
          const RevisaoConsultaWarningCard(),
          const SizedBox(height: 24),
          /*_buildInstructions(),
          const SizedBox(height: 24),*/
          _buildSubmitButton(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildConfirmarDados(MapEntry<String, dynamic> e) {
    return Column(
      children: [
        CustomInfoMapItem(e),
        const CustomDivider(),
      ],
    );
  }

  Widget _buildObservacoes() {
    final observacoes = controller.ctrlObservacoes.text;
    return Column(
      children: [
        observacoes.length <= 25
            ? CustomInfoMapItem(MapEntry('Observações', observacoes))
            : _buildBigObservacoes(observacoes),
        const CustomDivider(),
      ],
    );
  }

  Widget _buildBigObservacoes(String observacoes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Observações',
          style: const TextStyle(color: AppColors.grey, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Text(
          observacoes,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
/*
  Widget _buildInstructions() {
    return const Text(
      "A consulta requisitada será avaliada por um de nossos consultores, "
      "qualquer dúvida entre em contato através de uma de nossas plataformas de comunicação.",
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.grey, fontSize: 12),
    );
  }*/

  Widget _buildSubmitButton(BuildContext context) {
    return Observer(
      builder: (_) => CustomLoadButton(
          title: 'Agendar Consulta',
          loading: controller.loading,
          onPressed: () async {
            await controller.criarConsulta();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const AlertDialog(
                title: Text(
                  'Realizando agendamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Aguarde enquanto o processo de cadastro termina',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.navigateToHome();
            });
          }),
    );
  }
}
