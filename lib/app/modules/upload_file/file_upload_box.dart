import 'package:app_pde/app/modules/upload_file/upload_file_item.dart';
import 'package:app_pde/app/modules/upload_file/upload_file_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FileUploadBox extends StatefulWidget {
  const FileUploadBox();

  @override
  _FileUploadBoxState createState() => _FileUploadBoxState();
}

class _FileUploadBoxState extends ModularState<FileUploadBox, UploadFileStore> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          const PageSectionHeader('Arquivos'),
          const SizedBox(height: 12),
          ...controller.uploadFiles
              .map((arquivo) => UploadFileItem(arquivo))
              .toList(),
          controller.uploadFiles.isEmpty
              ? _buildAddFileBox()
              : IconButton(
                  onPressed: controller.selectMultFiles,
                  icon: const Icon(
                    MdiIcons.plusCircleOutline,
                    color: AppColors.primaryDark,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildAddFileBox() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(
          Constants.defaultBorderRadius,
        ),
      ),
      child: InkWell(
        onTap: controller.selectMultFiles,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              MdiIcons.fileUpload,
              color: AppColors.primaryDark,
              size: 36,
            ),
            SizedBox(height: 6),
            Text(
              'Toque para adicionar arquivos',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return const SizedBox();
          }
        },
      );
}
