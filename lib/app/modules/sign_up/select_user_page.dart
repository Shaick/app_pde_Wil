import 'package:app_pde/app/modules/login/widgets/login_page_header.dart';
import 'package:app_pde/app/modules/sign_up/select_user_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({Key? key}) : super(key: key);

  @override
  _SelectUserPageState createState() => _SelectUserPageState();
}

class _SelectUserPageState
    extends ModularState<SelectUserPage, SelectUserStore> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isScrollable: false,
      padding: false,
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
                const LoginPageHeader(title: 'Criar uma conta'),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selecione o perfil de usuário",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        CustomLoadButton(
                          title: 'Aluno',
                          loading: false,
                          onPressed: () {
                            controller.setAluno();
                          },
                        ),
                        CustomLoadButton(
                          title: 'Professor',
                          loading: false,
                          onPressed: () {
                            controller.setProfessor();
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        _buildLoginAccountLink()
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já tem uma conta?',
          style: TextStyle(color: AppColors.darkGrey),
        ),
        TextButton(
          onPressed: () => Modular.to.navigate('/login'),
          child: const Text(
            'Fazer login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
