import 'package:app_pde/app/modules/professor/financeiro/financeiro_professor_store.dart';
import 'package:app_pde/app/modules/professor/financeiro/widgets/financeiro_tab_professor.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_snack_bar.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class FinanceiroProfessorPage extends StatefulWidget {
  const FinanceiroProfessorPage({Key? key}) : super(key: key);

  @override
  _FinanceiroProfessorPageState createState() =>
      _FinanceiroProfessorPageState();
}

class _FinanceiroProfessorPageState
    extends ModularState<FinanceiroProfessorPage, FinanceiroProfessorStore> {
  ReactionDisposer? _disposer;

  @override
  void initState() {
    super.initState();
    controller.fetchNecessaryData();
    _disposer = reaction<String?>((_) => controller.successMessage, (message) {
      if (message != null) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 3),
          builder: (context, controller) => CustomSnackBar.success(
            message: message,
            controller: controller,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.navigate('/professor');
        return false;
      },
      child: Observer(
        builder: (_) => AppScaffold(
          hasDrawer: true,
          store: controller,
          isScrollable: false,
          title: 'Financeiro',
          tabBar: controller.loading
              ? null
              : const TabBar(
                  tabs: [
                    Tab(text: 'A RECEBER'),
                    Tab(text: 'RECEBIDOS'),
                  ],
                ),
          body: controller.loading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    FinanceiroTabProfessor(
                      controller.aReceber,
                      cardTitle: 'Total a receber',
                    ),
                    FinanceiroTabProfessor(
                      controller.recebidos,
                      cardTitle: 'Total recebido',
                      showWithdrawButton: false,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposer?.call();
  }
}
