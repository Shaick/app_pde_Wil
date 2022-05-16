import 'package:app_pde/app/modules/minhas_consultas_aluno/minhas_consultas_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/widgets/consultas_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConsultaTabAluno extends StatefulWidget {
  final List<ConsultaViewModel> consultas;
  const ConsultaTabAluno(this.consultas, {Key? key}) : super(key: key);

  @override
  _ConsultaTabAlunoState createState() => _ConsultaTabAlunoState();
}

class _ConsultaTabAlunoState
    extends ModularState<ConsultaTabAluno, MinhasConsultasStore> {
  @override
  Widget build(BuildContext context) {
    return ConsultasListView(
      consultas: widget.consultas,
      onRefresh: () => controller.fetchAllConsultas(),
      onTap: (consulta) => controller.pushDetalhesConsultaPage(consulta),
    );
  }
}
