import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/widgets/consultas_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../professor_store.dart';

class ConsultaTabProfessor extends StatefulWidget {
  final List<ConsultaViewModel>? consultas;

  const ConsultaTabProfessor(this.consultas, {Key? key}) : super(key: key);

  @override
  _ConsultaTabProfessorState createState() => _ConsultaTabProfessorState();
}

class _ConsultaTabProfessorState
    extends ModularState<ConsultaTabProfessor, ProfessorStore> {
  @override
  Widget build(BuildContext context) {
    return ConsultasListView(
      consultas: widget.consultas,
      onRefresh: () => controller.getConsultasProfessor(),
      onTap: (consulta) => controller.pushDetalhesConsultaPage(consulta),
    );
  }
}
