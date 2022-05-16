import 'package:app_pde/app/shared/base/custom_drawer.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/controllers/drawer_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_snack_bar.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AppScaffold extends StatefulWidget {
  final String? title;
  final Widget body;
  final bool isScrollable;
  final bool padding;
  final TabBar? tabBar;
  final bool hasDrawer;
  final BaseStore? store;
  final List<Widget>? actions;
  final bool onWillPop;
  final Widget? bottomNavigationBar;
  final bool goHome;
  final Function? navigateHome;

  AppScaffold(
      {Key? key,
      required this.body,
      this.title,
      this.isScrollable = true,
      this.padding = true,
      this.tabBar,
      this.hasDrawer = false,
      this.store,
      this.actions,
      this.onWillPop = false,
      this.bottomNavigationBar,
      this.goHome = false,
      this.navigateHome});

  static ScaffoldState of(BuildContext context) {
    final result = context.findAncestorStateOfType<ScaffoldState>();
    if (result != null) return result;
    throw Exception('Nenhum AppScaffold foi encontrado');
  }

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  ReactionDisposer? _disposer;

  @override
  void initState() {
    super.initState();
    if (widget.store != null) {
      _disposer = reaction<String?>(
        (_) => widget.store!.errorMessage,
        (errorMessage) {
          if (errorMessage == null) return;
          showFlash(
            context: context,
            duration: const Duration(seconds: 3),
            builder: (context, controller) => CustomSnackBar.error(
              message: errorMessage,
              controller: controller,
            ),
          );
        },
        equals: (_, __) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onWillPop
        ? WillPopScope(onWillPop: _onWillPop, child: _buildDefaultTab())
        : _buildDefaultTab();
  }

  Widget _buildDefaultTab() {
    return widget.tabBar != null
        ? DefaultTabController(
            initialIndex: 0,
            length: widget.tabBar!.tabs.length,
            child: _buildScaffold(),
          )
        : _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      //backgroundColor: AppColors.primary,
      drawer: widget.hasDrawer ? CustomDrawer() : null,
      appBar: widget.title != null
          ? AppBar(
              backgroundColor: AppColors.primary,
              title: Text(widget.title!),
              actions: widget.actions,
              bottom: widget.tabBar,
            )
          : null,
      body: widget.isScrollable
          ? SingleChildScrollView(child: _buildBody())
          : _buildBody(),
      bottomNavigationBar: widget.bottomNavigationBar,

    );
  }

  Widget _buildBody() {
    return widget.padding
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.body)
        : widget.body;
  }

  Future<bool> _onWillPop() async {
    if (widget.goHome) {
      Modular.get<DrawerStore>().selectItem(0);
      widget.navigateHome!();
      return false;
    }
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja sair do app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'NÃO',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'SIM',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    _disposer?.call();
  }
}
