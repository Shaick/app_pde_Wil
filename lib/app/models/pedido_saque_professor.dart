import 'package:equatable/equatable.dart';

import 'consulta_a_receber.dart';

class PedidoSaqueProfessor extends Equatable {
  final String? id;
  final String idProfessor;
  final String email;
  final String telefone;
  final List<ConsultaAReceber> consultasAReceber;
  final DateTime dataPedido;

  const PedidoSaqueProfessor({
    this.id,
    required this.idProfessor,
    required this.email,
    required this.telefone,
    required this.consultasAReceber,
    required this.dataPedido,
  });

  @override
  List<Object?> get props => [
        id,
        idProfessor,
        email,
        telefone,
        consultasAReceber,
        dataPedido,
      ];
}
