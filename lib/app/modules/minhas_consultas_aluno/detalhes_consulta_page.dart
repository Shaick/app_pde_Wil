import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_store.dart';

import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/add_file_button.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/consulta_files.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/consulta_status_card.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/detalhes_consulta_orcamentos.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_rating_dialog.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/upload_file_button.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:app_pde/app/shared/widgets/custom_info_map_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetalhesConsultaPage extends StatefulWidget {
  final ConsultaViewModel consulta;

  const DetalhesConsultaPage(
    this.consulta, {
    Key? key,
  }) : super(key: key);

  @override
  _DetalhesConsultaPageState createState() => _DetalhesConsultaPageState();
}

class _DetalhesConsultaPageState
    extends ModularState<DetalhesConsultaPage, DetalhesConsultaStore> {
  @override
  void initState() {
    super.initState();
    controller.consulta = widget.consulta;
    controller.loadDownloadedFiles(viewFiles: widget.consulta.arquivos);
    controller.consulta.verBtnAvalieConsulta ? _ratingDialog() : null;
    controller.loadOrcamentos(viewOrcamentos: widget.consulta.orcamentos);
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
      'Software de resposta': widget.consulta.softwareResposta!.isEmpty
          ? 'Não informado'
          : widget.consulta.softwareResposta,
      'Valores Especificos': widget.consulta.valEspecifico!.isEmpty
          ? 'Não informado'
          : widget.consulta.valEspecifico,
      'Tipos de arquivos resposta': widget.consulta.tipoArquivoResposta!.isEmpty
          ? 'Não informado'
          : newListTipos,
      'Observações': widget.consulta.obs
    };
  }

  Future<void> _ratingDialog() {
    return Future.delayed(
        const Duration(seconds: 1),
        () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomRatingDialog(
                onSubmitted: (result) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => const AlertDialog(
                            title: const Text(
                              'Enviando sua Avaliação',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Aguarde enquanto o processo termina',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ));
                  controller.setAvaliarConsulta(result.rating);
                },
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isScrollable: true,
      title: 'Detalhes #${widget.consulta.idNumerico}',
      body: Column(
        children: [
          const SizedBox(height: 12),
          ConsultaStatusCard(widget.consulta),
          const SizedBox(height: 48),
          const PageSectionHeader('Informações'),
          const SizedBox(height: 12),
          ..._buildDetails()
              .entries
              .map((detail) => _buildDetailItem(detail))
              .toList(),
          const SizedBox(height: 48),
          widget.consulta.isOrcamento == true
              ? const PageSectionHeader('Orçamentos')
              : Container(),
          const SizedBox(
            height: 12,
          ),
          widget.consulta.orcamentos!.isEmpty &&
                  widget.consulta.isOrcamento == false
              ? Container()
              : widget.consulta.orcamentos!.isNotEmpty &&
                      widget.consulta.isOrcamento == true
                  ? _buildOrcamentos()
                  : const Text("Nenhum Orcamento registrado"),
          const SizedBox(
            height: 12,
          ),
          const PageSectionHeader('Arquivos'),
          const SizedBox(height: 12),
          ConsultaFiles(
            widget.consulta,
            listFiles: controller.files,
          ),
          const SizedBox(height: 4),
          _buildDownloadAll(),
          const SizedBox(height: 12),
          AddFileButton(widget.consulta),
          const SizedBox(height: 12),
          UploadFileButton(widget.consulta),
          _buildListButtons(widget.consulta),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildDetailItem(MapEntry<String, dynamic> e) {
    return Column(
      children: [
        CustomInfoMapItem(e),
        const CustomDivider(),
      ],
    );
  }

  Widget _buildDownloadAll() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        controller.downloadAll(controller.files);
      },
      child: Container(
          height: 30,
          width: 130,
          //  decoration: BoxDecoration(border: Border.all(color: AppColors.primary, width: 2), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.download,
                size: 16,
                color: AppColors.primary,
              ),
              Text("Baixar todos.",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  Widget _buildListButtons(ConsultaViewModel consulta) {
    return Column(
      children: [
        consulta.verBtnPedirCorrecao!
            ? _buildPegarConsulta(
                text: consulta.textCorrecao != ''
                    ? 'Ver Correção'
                    : 'Pedir Correção',
                onPressed: () => controller.pushCorrecaoConsultaPage(consulta))
            : Container(),
        //consulta.verBtnAvalieConsulta
        //     _buildPegarConsulta(
        //        text: 'Avalie a Consulta', onPressed: () => _ratingDialog())
        //    : Container(),
      ],
    );
  }

  Widget _buildPegarConsulta(
      {required String text, required Function onPressed, ButtonStyle? style}) {
    return SizedBox(
      width: double.infinity,
      child: CustomLoadButton(
          style: style,
          title: text,
          loading: controller.loading,
          onPressed: () {
            onPressed();
          }),
    );
  }

  Widget _buildOrcamentos() {
    return Observer(
      builder: (_) => Column(
        children: controller.orcamentos
            .map((orcamento) =>
                DetalhesConsultasOrcamentos(orcamento, widget.consulta))
            .toList(),
      ),
    );
  }
}
