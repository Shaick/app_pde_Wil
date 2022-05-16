import 'dart:io';

import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/widgets/detalhes_consulta_file_item.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConsultaFiles extends StatelessWidget {
  final List<ArquivoViewModel> listFiles;
  final ConsultaViewModel consulta;
  ConsultaFiles(
    this.consulta, {
    required this.listFiles,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Container(
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(15),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              shrinkWrap: true,
              children:
                  listFiles.map((file) => _buildFileDisplay(file)).toList(),
            )));
  }

  Widget _buildFileDisplay(ArquivoViewModel file) {
    return Stack(
      children: [
        file.isImage
            ? _buildImageDisplay(file)
            : DetalhesConsultaFileItem(file, consulta)
      ],
    );
  }

  Widget _buildImageDisplay(ArquivoViewModel file) {
    return  file.canOpen()
            ? Image.file(
                File(file.devicePath!),
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Erro ao carregar imagem');
                },
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            : DetalhesConsultaFileItem(file, consulta);
  }
}
