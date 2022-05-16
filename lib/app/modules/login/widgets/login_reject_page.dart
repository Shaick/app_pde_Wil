import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../login_store.dart';
import 'login_page_header.dart';

class LoginRejectPage extends StatefulWidget {
  const LoginRejectPage({Key? key}) : super(key: key);

  @override
  _LoginRejectPageState createState() => _LoginRejectPageState();
}

class _LoginRejectPageState extends ModularState<LoginRejectPage, LoginStore> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isScrollable: false,
        padding: false,
        onWillPop: true,
        body: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const LoginPageHeader(title: 'Conta criada'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomCard(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              const Text(
                                'Cadastro ainda em análise',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              const Text(
                                'Seu cadastro foi realizado com sucesso, '
                                'mas deve esperar que seja analisado pela central para que tenha acesso.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomLoadButton(
                        title: 'Voltar',
                        loading: controller.loading,
                        onPressed: Modular.get<AuthController>().userLogout,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
