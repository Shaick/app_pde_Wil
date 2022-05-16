import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/widgets/consulta_files_professor.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:app_pde/app/shared/widgets/custom_info_map_item.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'detalhes_consulta_professor_store.dart';

class DetalhesConsultaProfessorPage extends StatefulWidget {
  final ConsultaViewModel consulta;
  const DetalhesConsultaProfessorPage(this.consulta, {Key? key})
      : super(key: key);

  @override
  State<DetalhesConsultaProfessorPage> createState() =>
      _DetalhesConsultaProfessorPageState();
}

class _DetalhesConsultaProfessorPageState extends ModularState<
    DetalhesConsultaProfessorPage, DetalhesConsultaProfessorStore> {
  @override
  void initState() {
    super.initState();
    controller.consulta = widget.consulta;
    controller.loadDownloadedFiles(viewFiles: widget.consulta.arquivos);
    controller.getIdPermission();
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

    var widgetToBuild = {
      'Matéria': widget.consulta.nomeMateria,
      'Data': widget.consulta.dataInicio,
      'Hora': widget.consulta.hora,
      'Software de resposta': widget.consulta.softwareResposta!.isEmpty
          ? 'Não informado'
          : widget.consulta.softwareResposta,
      'Valores Especificos': widget.consulta.valEspecifico!.isEmpty
          ? 'Não informado'
          : widget.consulta.valEspecifico,
      'Tipos de arquivos resposta': widget.consulta.tipoArquivoResposta == null
          ? 'Não informado'
          : newListTipos,
      'Observações': widget.consulta.obs,
    };

    // var removed = widget.consulta.valor.replaceRange(0, 3, '');
    var valor = controller.getValorOrcamentoProfessorLogado();

    if (valor != null) {
      widgetToBuild['Valor Orçado'] = valor;
    } else {
      var removed = widget.consulta.valor.replaceRange(0, 3, '');
      if (removed != "0,00") {
        widgetToBuild['Valor da Consulta'] = widget.consulta.valor;
      }
    }

    return widgetToBuild;
  }

  Future<void> _messagemPegarConsulta(ConsultaViewModel consulta) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Flexible(
                child: const Text(
                  'Confirma que deseja reservar essa consulta?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Modular.to.pop(),
                  child: const Icon(Icons.close))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Lembre-se que está se comprometendo à uma consulta, com desistência em até 24 horas antes do início agendado.',
                  style: TextStyle(fontSize: 14)),
              const SizedBox(height: 15),
              Row(children: [
                Flexible(
                  child: CustomLoadButton(
                      height: 35,
                      loading: controller.loading,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primary)),
                      onPressed: () {
                        Modular.to.pop();
                        controller.setProfessorConsulta(context, consulta);
                      },
                      title: 'Confirmo'),
                ),
              ])
            ],
          )),
    );
  }

  Future<void> _alertProfessorPendente() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Quase lá...\nCadastro ainda em análise',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: const Text(
            'O seu cadastro está sendo analisado pela central, após essa etapa terá acesso livre para pegar nossas consultas.',
            style: TextStyle(fontSize: 14)),
        actions: [
          CustomLoadButton(
              loading: controller.loading,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade600)),
              onPressed: () {
                Modular.to.pop();
              },
              title: 'Ok'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isScrollable: true,
      title: 'Detalhes #${widget.consulta.idNumerico}',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          _buildStatusCard(),
          const SizedBox(height: 48),
          _buildSectionHeader('Informações'),
          const SizedBox(height: 12),
          ..._buildDetails()
              .entries
              .map((detail) => _buildDetailItem(detail))
              .toList(),
          const SizedBox(height: 12),
          _buildSectionHeader('Arquivos'),
          const SizedBox(height: 12),
          ConsultaFilesProfessor(
            widget.consulta,
            listFiles: controller.files,
          ),
          const SizedBox(height: 4),
          _buildDownloadAll(),
          const SizedBox(height: 12),
          _buildButtonPressed(context, widget.consulta),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return CustomCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'STATUS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.consulta.color,
                ),
                height: 8,
                width: 8,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.consulta.status,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
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

  Widget _buildButtonPressed(context, ConsultaViewModel consulta) {
    return consulta.situacao == SituacaoConsulta.disponiveis
        ? Column(
            children: [
              widget.consulta.isOrcamento == true
                  ? _buildPegarConsulta(
                      text: 'Orçar Consulta',
                      onPressed: () {
                        controller.isPendente
                            ? _alertProfessorPendente()
                            : _settingModalBottomSheet(context);
                      })
                  : _buildPegarConsulta(
                      text: 'Pegar Consulta',
                      onPressed: () => controller.isPendente
                          ? _alertProfessorPendente()
                          : _messagemPegarConsulta(consulta)),
              _buildPegarConsulta(
                  text: 'Não Visualizar Consulta',
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red.shade700)),
                  onPressed: () => controller.isPendente
                      ? _alertProfessorPendente()
                      : controller.setBanirProfessor(context, consulta))
            ],
          )
        : consulta.situacao == SituacaoConsulta.agendadas &&
                consulta.textCorrecao != ''
            ? _buildPegarConsulta(
                text: 'Aluno Pediu Correção',
                onPressed: () => controller.isPendente
                    ? _alertProfessorPendente()
                    : controller.pushCorrecaoConsultaPage(consulta))
            : Container();
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        constraints: const BoxConstraints(minHeight: 300, maxHeight: 400),
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: AppColors.lightGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        elevation: 30.0,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Lembrando que ao orçar a atividade, torna-se um possível responsável pela mesma, '
                        'não podendo desistir dela caso seu orçamento seja escolhido.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildValorPagoField(),
              ],
            ),
          );
        });
  }

  Widget _buildPegarConsulta(
      {required String text, required Function onPressed, ButtonStyle? style}) {
    return SizedBox(
      width: double.infinity,
      child: CustomLoadButton(
          style: style,
          title: text,
          loading: controller.loading,
          onPressed: onPressed),
    );
  }

  Widget _buildValorPagoField() {
    bool isFirst = true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Column(
        children: [
          CustomTextField(
            label: 'Valor Orçamento',
            controller: controller.ctrlValorProfessor,
            validator: (value) {
              return null;
            },
            keyboardType: TextInputType.number,
            suffixIcon: const Icon(
              Icons.monetization_on,
              color: AppColors.monetizationIcon,
            ),
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
                selection:
                    TextSelection.collapsed(offset: formattedValue.length),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Observer(
      builder: (_) => CustomLoadButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.monetizationIcon),
          ),
          color: AppColors.monetizationIcon,
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
                    'Enviando Orçamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'Aguarde, estamos finalizando o orçamento',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
              }).then(
                (value) => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => Container(
                    height: 200,
                    width: 200,
                    child: const AlertDialog(
                      backgroundColor: AppColors.lightGrey,
                      content: Text(
                        'Parabens seu orçamento foi enviado!',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                  controller.popPage();
                },
              );
            }
          }),
    );
  }
}
