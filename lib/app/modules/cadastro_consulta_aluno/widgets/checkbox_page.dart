import 'package:app_pde/app/models/checkbox_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cadastro_consulta_aluno_store.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({Key? key, required this.item}) : super(key: key);

  final CheckBoxModel item;

  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState
    extends ModularState<CheckboxPage, CadastroConsultaAlunoStore> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.item.texto),
      value: widget.item.checked,
      onChanged: (value) {
        setState(() {
          widget.item.checked = value!;

          if (widget.item.texto == 'Feito a mão com foto digitalizada') {
            controller.foto = value;
          }
          if (widget.item.texto == 'PDF') {
            controller.pdf = value;
          }
          if (widget.item.texto == 'DWG') {
            controller.dwg = value;
          }
          if (widget.item.texto == 'XLSX') {
            controller.xlsx = value;
          }
          if (widget.item.texto == 'DOCX') {
            controller.docx = value;
          }
        });
      },
    );
  }
}
