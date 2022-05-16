import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:flutter/material.dart';

import 'package:app_pde/app/shared/utlis/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Widget icon;
  final void Function()? onTap;
  final Future<void> Function(ConsultaViewModel)? onTap2;

  final EdgeInsets? contentPadding;

  CustomListTile({
    Key? key,
    this.title = '',
    this.subtitle,
    this.trailing,
    this.leading,
    required this.icon,
    this.onTap,
    this.onTap2,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 24,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGrey)),
                    const SizedBox(height: 3),
                    subtitle != null
                        ? Text(subtitle!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ))
                        : Container()
                  ],
                ),
              ),
            ),
             Container(
                child: Material(
                  child: InkWell(
                    onTap: () async => await onTap2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [icon],
                    ),
                  ),
                ),
              
            )
          ],
        ),
      ),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
