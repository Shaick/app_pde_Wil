import 'package:app_pde/app/modules/login/login_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:app_pde/app/shared/widgets/custom_password_text_field.dart';
import 'package:app_pde/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'biometric_auth_switch.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({Key? key}) : super(key: key);

  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends ModularState<LoginPageForm, LoginStore> {
  @override
  void initState() {
    super.initState();
    controller.checkBiometricAvailability();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextField(
              label: 'E-mail',
              hint: 'Digite seu e-mail',
              controller: controller.ctrlLogin,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validaEmail,
            ),
            CustomPasswordTextField(
              controller: controller.ctrlSenha,
              validator: controller.validaSenha,
            ),
            TextButton(
              onPressed: () => Modular.to.pushNamed('/reset-password'),
              child: const Text('Esqueci minha senha',
                  style: TextStyle(color: AppColors.primary)),
            ),
            CustomLoadButton(
                title: 'Entrar',
                loading: controller.loading,
                onPressed: controller.login),
            if (controller.hasError) _buildErrorMessage(),
            const SizedBox(height: 10),
            if (controller.isBiometricAuthAvailable)
              BiometricAuthSwitch(controller: controller),
            const SizedBox(height: 10),
            _buildCreateAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Observer(
      builder: (_) => SizedBox(
        width: double.infinity,
        child: Text(
          controller.errorMessage!,
          maxLines: 2,
          style: const TextStyle(color: AppColors.error),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCreateAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não tem uma conta?',
          style: TextStyle(color: AppColors.primary),
        ),
        TextButton(
          onPressed: () => Modular.to.pushNamed('/sign-up/select-user'),
          child: const Text(
            'Criar minha conta',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.darkGrey,
            ),
          ),
        ),
      ],
    );
  }
}
