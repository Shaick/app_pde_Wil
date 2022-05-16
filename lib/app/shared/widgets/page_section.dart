import 'package:app_pde/app/shared/controllers/drawer_store.dart';
import 'package:app_pde/app/shared/utlis/drawer_items.dart';
import 'package:app_pde/app/shared/widgets/page_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class PageSection extends StatelessWidget {
  final controller = Modular.get<DrawerStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: (controller.menuAlunoOrProfessor
              ? allDrawerItems
              : allDrawerItemsProfessor)
          .asMap()
          .entries
          .map(
            (e) => Observer(
              builder: (_) => PageTile(
                label: e.value.labelText,
                iconData: e.value.icon,
                onTap: e.value.routeName != null
                    ? e.value.labelText == 'Fale Conosco'
                        // ignore: deprecated_member_use
                        ? () async => await launch(e.value.routeName!)
                        : () {
                            controller.selectItem(e.key);
                            return Modular.to.navigate(e.value.routeName!);
                          }
                    : e.value.onTap ?? () {},
                highlighted: e.key == controller.currentItemIndex,
              ),
            ),
          )
          .toList(),
    );
  }
}
