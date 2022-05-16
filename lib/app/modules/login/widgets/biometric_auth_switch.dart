import 'package:app_pde/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BiometricAuthSwitch extends StatelessWidget {
  final LoginStore controller;

  const BiometricAuthSwitch({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: controller.toggleBiometricAuth,
          child: Row(
            children: [
              Image.asset('assets/images/fingerprint.png', width: 70, height: 70),
              const Text('Ativar leitor de digital'),
            ],
          ),
        ),
        Observer(builder: (_) {
          return Switch(
            activeColor: Colors.blue,
            value: controller.isBiometricAuthOn,
            onChanged: (_) => controller.toggleBiometricAuth(),
          );
        }),
      ],
    );
  }
}
