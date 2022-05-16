import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/widgets/custom_load_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../detalhes_consulta_store.dart';

class UploadFileButton extends StatefulWidget {
  final ConsultaViewModel consulta;

  const UploadFileButton(this.consulta, {Key? key}) : super(key: key);

  @override
  _UploadFileButtonState createState() => _UploadFileButtonState();
}

class _UploadFileButtonState
    extends ModularState<UploadFileButton, DetalhesConsultaStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Form(
          child: Column(
            children: [
              controller.uploadFiles!.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: CustomLoadButton(
                        title: 'UPLOAD DOS ARQUIVOS',
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        loading: controller.loading,
                        onPressed: () {
                          controller.uploadArquivoApoio(
                              widget.consulta, widget.consulta.situacao);
                          showDialog(
                              context: context,
                              builder: (BuildContext builderContext) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context).pop();
                                });

                                return const AlertDialog(
                                  title: const Text(
                                    'Enviando arquivos',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              });
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
