import 'package:equatable/equatable.dart';

class Materia extends Equatable {
  final String id;
  final String? sigla;
  final String? nome;
  final String? descricao;
  final int? categoria;
  final String? idGrupo;
  final double? valorBaseProfessor;

  const Materia({
    required this.id,
     this.sigla,
     this.nome,
     this.descricao,
    required this.categoria,
     this.idGrupo,
     this.valorBaseProfessor,
  });

  @override
  List<Object?> get props {
    return [
      id,
      sigla,
      nome,
      descricao,
      categoria,
      idGrupo,
      valorBaseProfessor,
    ];
  }
}
