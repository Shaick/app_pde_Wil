import 'package:app_pde/app/modules/sign_up/sign_up_store.dart';
import 'package:app_pde/app/modules/sign_up/terms_of_use/terms_of_use_string.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TermsOfUsePage extends StatelessWidget {
  final controller = Modular.get<SignUpStore>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Termos de uso',
      isScrollable: false,
      body: Stack(
        children: [
          SingleChildScrollView(child: Html(data: termsOfUseString)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomLoadButton(
                  loading: false,
                  onPressed: () {
                    controller.aceitarTermos(true);
                    Modular.to.pop();
                  },
                  title: 'CONCORDO',
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
