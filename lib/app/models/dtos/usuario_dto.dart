import 'package:app_pde/app/models/aluno.dart';
import 'package:app_pde/app/models/professor.dart';
import 'package:app_pde/app/models/usuario.dart';
import 'package:app_pde/app/shared/utlis/mask_map.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UsuarioDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'Email')
  final String email;
  @JsonKey(name: 'IDPermissao')
  final dynamic idPermissao;
  @JsonKey(name: 'Telefone')
  final String telefone;
  @JsonKey(ignore: true)
  @JsonKey(name: 'TermosAceitos')
  final bool? termosAceitos;
  @JsonKey(name: 'Apelido')
  final String? apelido;
  @JsonKey(name: 'Materias')
  final List<String>? materias;
  @JsonKey(name: 'AgenciaBanco')
  final String? agenciaBanco;
  @JsonKey(name: 'ContaBanco')
  final String? contaBanco;
  @JsonKey(name: 'Banco')
  final String? banco;
  @JsonKey(name: 'CPF')
  final String? cpf;

  const UsuarioDTO({
    this.id,
    required this.email,
    required this.idPermissao,
    required this.telefone,
    this.termosAceitos,
    this.materias,
    this.apelido,
    this.agenciaBanco,
    this.contaBanco,
    this.banco,
    this.cpf,
  });

  factory UsuarioDTO.fromJson(Map<String, dynamic> json) =>
      _$UsuarioDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioDTOToJson(this);

  factory UsuarioDTO.fromDomain(Usuario model) => UsuarioDTO(
      email: model.email,
      idPermissao: int.parse(model.idPermissao),
      telefone: masks['cel']!.unmaskText(model.telefone),
      termosAceitos: model.termosAceitos,
      apelido: model.apelido,
      materias: model.materias,
      agenciaBanco: model.agenciaBanco,
      banco: model.banco,
      contaBanco: model.contaBanco,
      cpf:
          model.cpf != null ? masks['cpf']!.unmaskText(model.cpf!) : model.cpf);

  Usuario toDomain() {
    final maskedPhone = masks['cel']!.maskText(telefone);
    final maskedCpf = cpf != null ? masks['cpf']!.maskText(cpf!) : null;
    dynamic idTipoPermissao = '';

    if (idPermissao == "0" || idPermissao == "1") {
      idTipoPermissao = int.parse(idPermissao);
    } else {
      idTipoPermissao = idPermissao;
    }

    if (idTipoPermissao == 0) {
      return Aluno(
        id: id ?? '',
        email: email,
        apelido: apelido,
        idPermissao: idPermissao.toString(),
        telefone: maskedPhone,
        termosAceitos: termosAceitos,
        materias: materias,
        agenciaBanco: agenciaBanco,
        banco: banco,
        contaBanco: contaBanco,
        cpf: maskedCpf,
      );
    } else if (idTipoPermissao == 1) {
      return Professor(
        id: id ?? '',
        email: email,
        apelido: apelido,
        idPermissao: idPermissao.toString(),
        telefone: maskedPhone,
        termosAceitos: termosAceitos,
        materias: materias,
        agenciaBanco: agenciaBanco,
        banco: banco,
        contaBanco: contaBanco,
        cpf: maskedCpf,
      );
    } else {
      return Professor(
        id: id ?? '',
        email: email,
        apelido: apelido,
        idPermissao: idPermissao.toString(),
        telefone: maskedPhone,
        termosAceitos: termosAceitos,
        materias: materias,
        agenciaBanco: agenciaBanco,
        banco: banco,
        contaBanco: contaBanco,
        cpf: maskedCpf,
      );
    }
  }

  factory UsuarioDTO.fromDatabase(DataSnapshot snapshot) {
    final json = Map<String, dynamic>.from(snapshot.value as Map);
    return UsuarioDTO.fromJson(json).copyWith(id: snapshot.key);
  }

  UsuarioDTO copyWith({
    String? id,
    String? email,
    String? apelido,
    dynamic idPermissao,
    List<String>? materias,
    String? telefone,
    bool? termosAceitos,
    String? agenciaBanco,
    String? banco,
    String? contaBanco,
    String? cpf,
  }) {
    return UsuarioDTO(
      id: id ?? this.id,
      apelido: apelido ?? this.apelido,
      email: email ?? this.email,
      idPermissao: idPermissao ?? this.idPermissao,
      materias: materias ?? this.materias,
      telefone: telefone ?? this.telefone,
      termosAceitos: termosAceitos ?? this.termosAceitos,
      agenciaBanco: agenciaBanco ?? this.agenciaBanco,
      banco: banco ?? this.banco,
      contaBanco: contaBanco ?? this.contaBanco,
      cpf: cpf ?? this.cpf,
    );
  }
}
