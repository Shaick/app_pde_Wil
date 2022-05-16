import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/modules/professor/detalhe_consulta/detalhes_consulta_professor_store.dart';

abstract class FileOption {
  String get labelText;

  void onSelected({
    required DetalhesConsultaProfessorStore controller,
    required ArquivoViewModel file,
  });
}

class DeleteFileOption implements FileOption {
  const DeleteFileOption();

  @override
  String get labelText => 'Excluir';

  @override
  void onSelected({
    required DetalhesConsultaProfessorStore controller,
    required ArquivoViewModel file,
  }) {
    controller.deleteFile(file);
  }
}

const fileOptions = [
  DeleteFileOption(),
];
