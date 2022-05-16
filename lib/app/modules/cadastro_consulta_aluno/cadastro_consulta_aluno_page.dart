import 'package:app_pde/app/modules/cadastro_consulta_aluno/cadastro_consulta_aluno_store.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/dates_cadastro_consulta.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/detalhes_cadastro_consulta.dart';
import 'package:app_pde/app/modules/upload_file/file_upload_box.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/informacoes_adicionais.dart';
import 'package:app_pde/app/shared/widgets/app_scaffold.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastrarConsultaAlunoPage extends StatefulWidget {
  const CadastrarConsultaAlunoPage({Key? key}) : super(key: key);

  @override
  _CadastrarConsultaAlunoPageState createState() =>
      _CadastrarConsultaAlunoPageState();
}

class _CadastrarConsultaAlunoPageState extends ModularState<
    CadastrarConsultaAlunoPage, CadastroConsultaAlunoStore> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasDrawer: true,
      title: "Agendamento",
      store: controller,
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            const DatesCadastroConsulta(),
            const SizedBox(height: 48),
            const DetalhesCadastroConsulta(),
            const SizedBox(height: 48),
            const FileUploadBox(),
            const SizedBox(height: 48),
            const InformacoesAdicionais(),
            const SizedBox(height: 48),
            Observer(
              builder: (_) => CustomLoadButton(
                title: 'Próximo',
                loading: controller.loading,
                onPressed: () {
                  controller.shouldPushNextPage(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
