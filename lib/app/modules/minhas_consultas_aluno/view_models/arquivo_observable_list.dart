import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mobx/mobx.dart';

class ArquivoObservableList extends ObservableList<ArquivoViewModel> {
  void changeFileTaskId({
    ArquivoViewModel? file,
    int? index,
    required String newTaskId,
  }) {
    int fileIndex;
    file != null ? fileIndex = super.indexOf(file) : fileIndex = index!;
    super[fileIndex] = super[fileIndex].copyWith(taskId: newTaskId);
  }

  void changeFileStatus({
    ArquivoViewModel? file,
    int? index,
    required DownloadTaskStatus newStatus,
  }) {
    int fileIndex;
    file != null ? fileIndex = super.indexOf(file) : fileIndex = index!;
    super[fileIndex] = super[fileIndex].copyWith(status: newStatus);
  }
}
