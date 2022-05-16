// ignore_for_file: unnecessary_import

import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/orcamento_view_model.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DetalhesConsultasOrcamentos extends StatefulWidget {
  final OrcamentoViewModel orcamentoViewModel;
  final ConsultaViewModel consulta;

  const DetalhesConsultasOrcamentos(this.orcamentoViewModel, this.consulta,
      {Key? key})
      : super(key: key);

  @override
  _DetalhesConsultasOrcamentosState createState() =>
      _DetalhesConsultasOrcamentosState();
}

class _DetalhesConsultasOrcamentosState
    extends ModularState<DetalhesConsultasOrcamentos, DetalhesConsultaStore> {
  void _handleTap() {
    if (widget.orcamentoViewModel.escolhido == true) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => const AlertDialog(
                title: const Text(
                  'Orçamento inválido!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  'Você já escolheu um orçamento',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ));
    } else {
      controller.alunoEscolheOrcamento(widget.orcamentoViewModel.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      onTap: _handleTap,
      title: const Text('Valor do Orçamento: '),
      subtitle:
          Text(' R\$${widget.orcamentoViewModel.valorConsulta.toString()}'),
      leading: widget.orcamentoViewModel.escolhido == true
          ? const Icon(MdiIcons.check, color: AppColors.success)
          : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
