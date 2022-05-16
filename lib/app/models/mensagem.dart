import 'package:app_pde/app/models/arquivo.dart';
import 'package:equatable/equatable.dart';

class Mensagem extends Equatable {
  final String id;
  final String idRemetente;
  final String texto;
  final bool visto;
  final DateTime timestamp;
  final List<Arquivo>? arquivos;

  const Mensagem({
    required this.id,
    required this.idRemetente,
    required this.texto,
    required this.visto,
    required this.timestamp,
    this.arquivos,
  });

  @override
  List<Object?> get props => [
        id,
        idRemetente,
        texto,
        visto,
        timestamp,
        arquivos,
      ];
}
