import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/correcao_view_model.dart';
import 'package:app_pde/app/modules/professor/widgets/detalhes_consulta_file_item_professor.dart';
import 'package:app_pde/app/modules/upload_file/file_upload_box.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'correcao_consulta_store.dart';

class CorrecaoConsultaPage extends StatefulWidget {
  final ConsultaViewModel consulta;

  const CorrecaoConsultaPage(this.consulta, {Key? key}) : super(key: key);

  @override
  State<CorrecaoConsultaPage> createState() => _CorrecaoConsultaPageState();
}

class _CorrecaoConsultaPageState
    extends ModularState<CorrecaoConsultaPage, CorrecaoConsultaStore> {
  @override
  void initState() {
    super.initState();
    controller.init(widget.consulta);
  }

  @override
  void dispose() {
    super.dispose();
    // controller.reloadConsulta(widget.consulta.isAluno);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isScrollable: true,
        title: 'Correções #${controller.idNumber}',
        body: Column(
          children: [
            const SizedBox(height: 48),
            _buildDetailItem(context),
            _buildMessageErroProfessor(widget.consulta.isAluno),
            const SizedBox(height: 30)
          ],
        ));
  }

  Widget _buildDetailItem(context) {
    return Observer(builder: (_) {
      return Column(
          children: controller.listCorrecao.map<Widget>((e) {
        List<String> texto = controller.text(e.tipoCorrecao, e.isAluno);
        return Column(
          children: [
            const SizedBox(height: 8),
            _buildSectionHeader(texto[0]),
            const SizedBox(height: 12),
            _buildText(e.descricao),
            _buildFileItems(e),
            controller.erroProfessor == null
                ? _buildOptionsResp(context,e, texto)
                : Container(),
          ],
        );
      }).toList());
    });
  }

  Widget _buildOptionsResp(context,CorrecaoViewModel element, texto) {
    return element.options
        ? Column(
            children: [
              controller.newReply
                  ? Container()
                  : _buildPegarConsulta(
                      text: '${texto[1]}',
                      onPressed: () => controller.registreError(context,
                          element.tipoCorrecao, element.isAluno)),
              _buildSubmitCorrecao(texto[3], context, element),
              element.tipoCorrecao != TipoCorrecao.reclamacao
                  ? _buildPegarConsulta(
                      text: '${controller.newReply ? 'voltar' : texto[2]}',
                      onPressed: () => controller.habiliteSubmit())
                  : Container(),
            ],
          )
        : Container();
  }

  Widget _buildSubmitCorrecao(
      String texto, BuildContext context, CorrecaoViewModel correcao) {
    return Observer(
        builder: (_) => controller.newReply
            ? Column(
                children: [
                  const SizedBox(height: 12),
                  _buildText(texto),
                  const SizedBox(height: 8),
                  _buildReplyField(),
                  const SizedBox(height: 12),
                  const FileUploadBox(),
                  const SizedBox(height: 12),
                  _buildPegarConsulta(
                      text: 'Enviar',
                      onPressed: () =>
                          controller.sendQueryCorrection(context, correcao)),
                ],
              )
            : Container());
  }

  Widget _buildText(String txt) {
    return txt != ''
        ? Text(txt,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        : Container();
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

  Widget _buildPegarConsulta(
      {required String text, required Function onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: CustomLoadButton(
          title: text,
          loading: controller.loading,
          onPressed: () => onPressed()),
    );
  }

  Widget _buildReplyField() {
    return Form(
      key: controller.formKey,
      child: TextFormField(
        validator: (value) => controller.validaReply(value!),
        controller: controller.replyController,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
            hintText: 'Digite sua descrição detalhada aqui.',
            labelText: 'Digite *'),
      ),
    );
  }

  Widget _buildFileItems(CorrecaoViewModel element) {
    return Observer(
      builder: (_) => Column(
          children: element.filesArquivos
              .map((arquivo) => DetalhesConsultaFileItemProfessor(
                  arquivo, widget.consulta,
               ))
              .toList()),
    );
  }

  Widget _buildMessageErroProfessor(bool isAluno) {
    return controller.erroProfessor != null
        ? Column(
            children: [
              const SizedBox(height: 20),
              Text(controller.textError(isAluno)),
            ],
          )
        : Container();
  }
}
