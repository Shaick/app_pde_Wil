import 'package:app_pde/app/modules/home/home_aluno_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/bottom_navigation_routes.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeAlunoStore> {
  @override
  void initState() {
    super.initState();
    controller.fetchNecessaryData();
    controller.setupInteractedMessage();
    controller.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => AppScaffold(
          isScrollable: false,
          padding: false,
          onWillPop: true,
          body: controller.loading
              ? const Center(child: CircularProgressIndicator())
              : RouterOutlet(),
          bottomNavigationBar:
              controller.loading ? null : _buildBottomNavigationBar()),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Observer(
      builder: (_) => BottomNavigationBar(
        //backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.accent,
        elevation: 20,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        selectedIconTheme: const IconThemeData(size: 40),
        unselectedIconTheme: const IconThemeData(size: 25),
        currentIndex: controller.currentPageIndex,
        onTap: controller.changePage,
        items: allBottomNavigationRoutes
            .map((e) =>
                BottomNavigationBarItem(icon: Icon(e.icon), label: e.labelText))
            .toList(),
      ),
    );
  }

  bool currentPage() {
    if (controller.currentPageIndex == 1) {
      controller.changePage(0);
      return false;
    } else
      return true;
  }
}
