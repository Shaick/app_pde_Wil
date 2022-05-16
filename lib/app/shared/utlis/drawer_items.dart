import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DrawerItem {
  final String labelText;
  final IconData icon;
  final String? routeName;
  final VoidCallback? onTap;

  const DrawerItem({
    required this.labelText,
    required this.icon,
    this.routeName,
    this.onTap,
  });
}

final allDrawerItems = [
  const DrawerItem(
    labelText: 'Início',
    icon: Icons.home,
    routeName: '/home/minhas-consultas',
  ),
  const DrawerItem(
    labelText: 'Minha conta',
    icon: Icons.account_circle,
    routeName: '/home/minha-conta',
  ),
  const DrawerItem(
    labelText: 'Mensagens',
    icon: Icons.message,
    routeName: '/home/mensagens',
  ),
  const DrawerItem(
    labelText: 'Fale Conosco',
    icon: MdiIcons.whatsapp,
    routeName: 'https://wa.me/message/XXILK5WTND7YF1',
  ),
  DrawerItem(
    labelText: 'Logout',
    icon: Icons.exit_to_app,
    onTap: Modular.get<AuthController>().userLogout,
  ),
];

final allDrawerItemsProfessor = [
  const DrawerItem(
    labelText: 'Início',
    icon: Icons.home,
    routeName: '/professor',
  ),
  const DrawerItem(
    labelText: 'Minha conta',
    icon: Icons.account_circle,
    routeName: '/professor/minha-conta',
  ),
  const DrawerItem(
      labelText: 'Mensagens',
      icon: Icons.message,
      routeName: '/professor/mensagens'),
  const DrawerItem(
    labelText: 'Financeiro',
    icon: Icons.attach_money,
    routeName: '/professor/financeiro',
  ),
  const DrawerItem(
    labelText: 'Fale Conosco',
    icon: MdiIcons.whatsapp,
    routeName: 'https://wa.me/message/XXILK5WTND7YF1',
  ),  
  DrawerItem(
    labelText: 'Logout',
    icon: Icons.exit_to_app,
    onTap: Modular.get<AuthController>().userLogout,
  ),
];
