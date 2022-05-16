import 'package:app_pde/app/modules/minhas_consultas_aluno/consulta_tab_aluno.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/minhas_consultas_store.dart';
import 'package:app_pde/app/shared/base/custom_drawer.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MinhasConsultasAlunoPage extends StatefulWidget {
  const MinhasConsultasAlunoPage();

  @override
  _MinhasConsultasAlunoPageState createState() =>
      _MinhasConsultasAlunoPageState();
}

class _MinhasConsultasAlunoPageState
    extends ModularState<MinhasConsultasAlunoPage, MinhasConsultasStore> {
  @override
  void initState() {
    super.initState();
    controller.fetchNecessaryData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: CustomDrawer(),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverAppBar(
                  title: Text("Minhas Consultas"),
                  backgroundColor: AppColors.primary,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    indicatorWeight: 7,
                    tabs: [
                      Tab(text: 'Andamento'),
                      Tab(text: 'Pendentes'),
                      Tab(text: 'Finalizadas'),
                    ],
                  ),
                ),
              ];
            },
            body: controller.loading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      ConsultaTabAluno(controller.consultasAndamento),
                      ConsultaTabAluno(controller.consultasPendentes),
                      ConsultaTabAluno(controller.consultasFinalizadas),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
