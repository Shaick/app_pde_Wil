import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/upload_file/upload_file_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UploadFileItem extends StatelessWidget {
  final ArquivoViewModel file;

  UploadFileItem(this.file, {Key? key}) : super(key: key);

  final controller = Modular.get<UploadFileStore>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(file.displayName),
      onTap: () => controller.openFile(file),
      leading: Icon(
        file.isImage ? MdiIcons.image : MdiIcons.file,
        color: AppColors.primary,
      ),
      trailing: IconButton(
        onPressed: () => controller.removeFile(file),
        icon: const Icon(
          MdiIcons.close,
          color: AppColors.error,
        ),
      ),
    );
  }
}
