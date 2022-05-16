import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DetalhesConsultaFileItem extends StatefulWidget {
  final ArquivoViewModel arquivo;
  final ConsultaViewModel consulta;
  const DetalhesConsultaFileItem(this.arquivo, this.consulta, {Key? key})
      : super(key: key);

  @override
  _DetalhesConsultaFileItemState createState() =>
      _DetalhesConsultaFileItemState();
}

class _DetalhesConsultaFileItemState
    extends ModularState<DetalhesConsultaFileItem, DetalhesConsultaStore> {
  Widget _calculateLeadingIcon() {
    if (widget.arquivo.status == DownloadTaskStatus.complete) {
      return const Icon(MdiIcons.file, size: 70, color: AppColors.success);
    } else if (widget.arquivo.status == DownloadTaskStatus.failed) {
      return const Icon(MdiIcons.replay, size: 70, color: AppColors.error);
    } else if (widget.arquivo.status == DownloadTaskStatus.undefined) {
      return const Icon(MdiIcons.fileDownload,
          size: 70, color: AppColors.primary);
    } else {
      return const Center(
          child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ));
    }
  }

  Widget _calculateLeadingImage() {
    if (widget.arquivo.status == DownloadTaskStatus.complete) {
      return image(300);
    } else if (widget.arquivo.status == DownloadTaskStatus.failed) {
      return Stack(
        children: [
          image(30),
          Center(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    } else if (widget.arquivo.status == DownloadTaskStatus.undefined) {
      return Stack(
        children: [
          image(30),
          Center(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.download,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    } else {
      return const Center(
          child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ));
    }
  }

  Widget image(int cacheWidth) {
    return Container(
      height: 200,
      width: 200,
      child: Image.network(
        widget.arquivo.downloadUrl!,
        errorBuilder: (context, error, stackTrace) {
          return const Text('Erro ao carregar imagem');
        },
        cacheWidth: cacheWidth,
        fit: BoxFit.cover,
      ),
    );
  }

  void _handleTap() {
    if (widget.arquivo.status == DownloadTaskStatus.complete) {
      controller.openFile(widget.arquivo);
    } else if (widget.arquivo.status == DownloadTaskStatus.failed) {
      controller.retryDownload(widget.arquivo);
    } else if (widget.arquivo.status == DownloadTaskStatus.undefined) {
      controller.requestDownload(widget.arquivo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.arquivo.isImage
        ? InkWell(
            onTap: _handleTap,
            child: _calculateLeadingImage(),
          )
        : ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            title: _calculateLeadingIcon(),
            subtitle: Text(
              widget.arquivo.displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
            onTap: _handleTap,
          );
  }
}
