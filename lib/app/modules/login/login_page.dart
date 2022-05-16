import 'package:app_pde/app/modules/login/widgets/login_page_form.dart';
import 'package:app_pde/app/modules/login/widgets/login_page_header.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isScrollable: false,
      padding: false,
      onWillPop: true,
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LoginPageHeader(title: 'Login'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: LoginPageForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
