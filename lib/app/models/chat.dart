import 'package:equatable/equatable.dart';

import 'package:app_pde/app/models/mensagem.dart';

class Chat extends Equatable {
  final String id;
  final String idProfessor;
  final String idAluno;
  final String idMateria;
  final String idNumerico;
  final bool concluido;
  final List<Mensagem> mensagens;

  const Chat({
    required this.id,
    required this.idProfessor,
    required this.idAluno,
    required this.idMateria,
    required this.idNumerico,
    required this.concluido,
    required this.mensagens,
  });

  bool get isEmpty => mensagens.isEmpty;

  @override
  List<Object?> get props => [
        id,
        idProfessor,
        idAluno,
        idMateria,
        idNumerico,
        concluido,
        mensagens,
      ];
}
