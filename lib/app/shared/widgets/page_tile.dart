import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  const PageTile({
    required this.label,
    required this.iconData,
    required this.onTap,
    required this.highlighted,
  });

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppColors.primary : AppColors.grey,
        ),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? AppColors.primary : Colors.grey,
      ),
      tileColor:
          highlighted ? AppColors.primaryLight.withOpacity(.1) : Colors.white,
      onTap: () {
        AppScaffold.of(context).openEndDrawer();
        onTap();
      },
    );
  }
}
