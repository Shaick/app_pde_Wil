import 'package:app_pde/app/models/checkbox_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cadastro_consulta_aluno_store.dart';

class CheckboxOrcamentoPage extends StatefulWidget {
  const CheckboxOrcamentoPage({Key? key, required this.item}) : super(key: key);

  final CheckBoxModel item;

  @override
  _CheckboxOrcamentoPageState createState() => _CheckboxOrcamentoPageState();
}

class _CheckboxOrcamentoPageState extends ModularState<CheckboxOrcamentoPage, CadastroConsultaAlunoStore> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => CheckboxListTile(
        title: Text(widget.item.texto),
        value: widget.item.checked,
        onChanged: (value){
          setState((){
            widget.item.checked = value!;

            if(widget.item.texto == 'Quero um Orçamento'){
              controller.addIsOrcamento(value);
            }
          });
        },
        subtitle: controller.isOrcamento ? const Text("Lembre-se que todos os professores poderão visualizar seu pedido e você poderá escolher uma das opções disponíveis. "
            "Qualquer dúvida, entre em contato com um de nossos atendentes.") : Container(),
      ),
    );
  }
}
