import 'package:app_pde/app/models/usuario.dart';

class Aluno extends Usuario {
  const Aluno({
    required String id,
    required String email,
    required String idPermissao,
    required String telefone,
    String? apelido,
    bool? termosAceitos,
    List<String>? materias,
    String? agenciaBanco,
    String? contaBanco,
    String? banco,
    String? cpf,
  }) : super(
          id: id,
          email: email,
          apelido: apelido,
          idPermissao: idPermissao,
          telefone: telefone,
          termosAceitos: termosAceitos,
          materias: materias,
          agenciaBanco: agenciaBanco,
          contaBanco: contaBanco,
          banco: banco,
          cpf: cpf,
        );
}
