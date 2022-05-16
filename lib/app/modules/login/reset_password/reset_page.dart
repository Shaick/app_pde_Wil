import 'package:app_pde/app/modules/login/reset_password/reset_store.dart';
import 'package:app_pde/app/modules/login/widgets/login_page_header.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_snack_bar.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends ModularState<ResetPage, ResetStore> {
  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = reaction((_) => controller.successMessage, (message) {
      if (message != null)
        showFlash(
          context: context,
          duration: const Duration(seconds: 4),
          builder: (context, controller) {
            return CustomSnackBar.success(
                message: message as String, controller: controller);
          },
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const LoginPageHeader(title: 'Redefinir senha'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ColumnInputs(controller: controller),
                  ),
                ],
              ),
              const BackButton(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposer.call();
  }
}

class ColumnInputs extends StatelessWidget {
  final ResetStore controller;
  const ColumnInputs({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: controller.formKey,
      child: Observer(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
                'Digite o e-mail do seu cadastro para refinir a sua senha de acesso.',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 15),
            CustomTextField(
              label: 'E-mail',
              hint: 'E-mail de Recuperação',
              onChanged: (value) {},
              controller: controller.ctrlLogin,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validaEmail,
            ),
            CustomLoadButton(
                title: 'Enviar e-mail',
                loading: controller.loading,
                onPressed: () {
                  controller.resetCredential();
                }),
            const SizedBox(height: 15),
            if (controller.hasError)
              Observer(builder: (_) {
                return SizedBox(
                  width: size.width,
                  child: Text(controller.errorMessage!,
                      maxLines: 2,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center),
                );
              }),
          ],
        );
      }),
    );
  }
}
