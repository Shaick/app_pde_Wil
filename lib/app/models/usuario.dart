import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String email;
  final String idPermissao;
  final String telefone;
  final bool? termosAceitos;

  final String? apelido;
  final String? agenciaBanco;
  final String? contaBanco;
  final String? banco;
  final String? cpf;

  final List<String>? materias;

  const Usuario({
    required this.id,
    required this.email,
    required this.apelido,
    required this.idPermissao,
    required this.telefone,
    this.termosAceitos,
    this.materias,
    this.agenciaBanco,
    this.contaBanco,
    this.banco,
    this.cpf,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      apelido,
      idPermissao,
      telefone,
      termosAceitos,
      agenciaBanco,
      contaBanco,
      banco,
      cpf,
      materias,
    ];
  }
}
