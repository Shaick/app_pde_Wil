import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:app_pde/app/models/mensagem.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/arquivo_view_model.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';

class MensagemViewModel {
  final String id;
  final String texto;
  final bool visto;
  final String data;
  final List<ArquivoViewModel>? arquivos;
  final bool souEu;

  MensagemViewModel({
    required this.id,
    required this.texto,
    required this.visto,
    required this.data,
    this.arquivos,
    required this.souEu,
  });

  bool get temArquivos => arquivos != null;
  bool get temTexto => texto.isNotEmpty;

  factory MensagemViewModel.fromDomain(Mensagem mensagem) {
    final formattedDate = DateFormat('H:mm • dd/MM').format(mensagem.timestamp);
    final userId = Modular.get<AuthController>().user?.id;
    return MensagemViewModel(
      id: mensagem.id,
      texto: mensagem.texto,
      visto: mensagem.visto,
      data: formattedDate,
      souEu: userId == mensagem.idRemetente,
      arquivos: mensagem.arquivos
          ?.map(
            (e) => ArquivoViewModel(
              displayName: e.nome,
              fileName: e.nome,
              id: e.id,
              downloadUrl: e.downloadUrl,
              storagePath: e.storagePath,
            ),
          )
          .toList(),
    );
  }

  MensagemViewModel copyWith({
    String? id,
    String? texto,
    bool? visto,
    String? data,
    List<ArquivoViewModel>? arquivos,
    bool? souEu,
  }) {
    return MensagemViewModel(
      id: id ?? this.id,
      texto: texto ?? this.texto,
      visto: visto ?? this.visto,
      data: data ?? this.data,
      arquivos: arquivos ?? this.arquivos,
      souEu: souEu ?? this.souEu,
    );
  }
}
