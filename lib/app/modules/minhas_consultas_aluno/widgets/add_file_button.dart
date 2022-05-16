import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../detalhes_consulta_store.dart';

class AddFileButton extends StatefulWidget {
  final ConsultaViewModel consulta;

  const AddFileButton(this.consulta, {Key? key}) : super(key: key);

  @override
  _AddFileButtonState createState() => _AddFileButtonState();
}

class _AddFileButtonState extends ModularState<AddFileButton, DetalhesConsultaStore> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_){
        return Form(
          child: Column(
            children: [
              widget.consulta.situacao != SituacaoConsulta.finalizada ?
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 12))),
                  onPressed: () {
                    controller.selectMultFiles();
                  },
                  icon: controller.uploadFiles!.isEmpty ? const Icon(MdiIcons.plus) : const Icon(MdiIcons.check),
                  label: controller.uploadFiles!.isEmpty ? const Text(
                    'ADICIONAR ARQUIVO',
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ): const Text(
                    'ARQUIVOS ADICIONADOS',
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ) : Container()
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}
