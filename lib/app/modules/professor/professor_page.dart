import 'package:app_pde/app/modules/professor/professor_store.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/consulta_tab_professor.dart';

class ProfessorPage extends StatefulWidget {
  const ProfessorPage({Key? key}) : super(key: key);

  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends ModularState<ProfessorPage, ProfessorStore> {
  @override
  void initState() {
    super.initState();
    controller.getToken();
    controller.fetchNecessaryData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => AppScaffold(
        title: 'Consultas',
        hasDrawer: true,
        isScrollable: false,
        onWillPop: true,
        store: controller,
        tabBar: controller.loading
            ? null
            : const TabBar(
                tabs: [
                  Tab(text: 'DISPONIVEIS'),
                  Tab(
                    text: 'ORÇADAS',
                  ),
                  Tab(text: 'AGENDADAS'),
                  Tab(text: 'FINALIZADAS'),
                ],
              ),
        body: controller.loading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  ConsultaTabProfessor(
                    controller.consultasDisponiveis,
                  ),
                  ConsultaTabProfessor(controller.consultasOrcadas),
                  ConsultaTabProfessor(controller.consultasAtendidas),
                  ConsultaTabProfessor(controller.consultasConcluidas),
                ],
              ),
      ),
    );
  }
}
