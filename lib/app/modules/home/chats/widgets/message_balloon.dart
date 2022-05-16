import 'dart:io';

import 'package:app_pde/app/modules/home/chats/chat_download_store.dart';
import 'package:app_pde/app/modules/home/chats/view_models/mensagem_view_model.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageBalloon extends StatefulWidget {
  final MensagemViewModel mensagem;

  const MessageBalloon(
    this.mensagem, {
    Key? key,
  }) : super(key: key);

  @override
  State<MessageBalloon> createState() => _MessageBalloonState();
}

class _MessageBalloonState
    extends ModularState<MessageBalloon, ChatDownloadStore> {
  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(Constants.defaultBorderRadius);
    return Row(
      mainAxisAlignment: widget.mensagem.souEu
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding:
                const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
            decoration: BoxDecoration(
              color: widget.mensagem.souEu
                  ? AppColors.accent
                  : AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomLeft: widget.mensagem.souEu ? radius : Radius.zero,
                bottomRight: widget.mensagem.souEu ? Radius.zero : radius,
              ),
            ),
            child: Column(
              crossAxisAlignment: widget.mensagem.souEu
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mensagem.texto,
                  style: TextStyle(
                    color: widget.mensagem.souEu
                        ? Colors.white
                        : AppColors.darkGrey,
                  ),
                ),
                if (widget.mensagem.temArquivos) _buildAttachedFiles(),
                const SizedBox(height: 4),
                Text(
                  widget.mensagem.data,
                  style: TextStyle(
                    fontSize: 8,
                    color: widget.mensagem.souEu
                        ? Colors.white.withOpacity(.5)
                        : AppColors.darkGrey.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachedFiles() {
    return Column(
      children: widget.mensagem.arquivos!
          .map((e) => ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: e.canDownload
                    ? _buildFileDisplay(e)
                    : const LinearProgressIndicator(),
              ))
          .toList(),
    );
  }

  Widget _buildFileDisplay(ArquivoViewModel file) {
    return GestureDetector(
      onTap: () => controller.openFile(file),
      child: Stack(
        children: [
          file.isImage ? _buildImageDisplay(file) : _buildDocumentDisplay(file),
        ],
      ),
    );
  }

  Widget _buildImageDisplay(ArquivoViewModel file) {
    return file.canOpen()
        ? ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300, minHeight: 200),
            child: Image.file(
              File(file.devicePath!),
              errorBuilder: (context, error, stackTrace) {
                return const Text('Erro ao carregar imagem');
              },
              width: 200,
              fit: BoxFit.cover,
            ),
          )
        : Image.network(
            file.downloadUrl!,
            errorBuilder: (context, error, stackTrace) {
              return const Text('Erro ao carregar imagem');
            },
            width: 200,
            height: 200,
            cacheWidth: 30,
            fit: BoxFit.cover,
          );
  }

  Widget _buildDocumentDisplay(ArquivoViewModel file) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        file.canOpen()
            ? const Icon(
                MdiIcons.file,
                color: AppColors.success,
              )
            : const Icon(
                MdiIcons.fileDownload,
                color: AppColors.accent,
              ),
        const SizedBox(width: 6),
        Text(
          file.fileName.substring(0, 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
