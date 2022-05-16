import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 40, right: 40, top: statusBarHeight),
      color: AppColors.primary,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
