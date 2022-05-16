import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';

abstract class FileOption {
  String get labelText;

  void onSelected({
    required DetalhesConsultaStore controller,
    required ArquivoViewModel file,
  });
}

class DeleteFileOption implements FileOption {
  const DeleteFileOption();

  @override
  String get labelText => 'Excluir';

  @override
  void onSelected({
    required DetalhesConsultaStore controller,
    required ArquivoViewModel file,
  }) {
    controller.deleteFile(file);
  }
}
