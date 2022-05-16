import 'package:equatable/equatable.dart';

import 'arquivo.dart';
import 'orcamento.dart';
import 'professor_banido.dart';

enum SituacaoConsulta {
  disponiveis,
  agendadas,
  andamento,
  pendente,
  finalizada,
  orcadas,
}

class Consulta extends Equatable {
  final String id;
  final String idNumerico;
  final String idMateria;
  final String idAluno;
  final String idProfessor;
  final String? idFaturalugu;

  final SituacaoConsulta situacao;
  final String descricao;

  final DateTime dataInicio;
  final DateTime dataFim;
  final DateTime timestamp;

  final double? valorConsulta;
  final double valorProfessor;

  final List<Arquivo> arquivos;

  final bool? erroProfessor;
  final bool? professorPago;
  final int? estrelas;

  final String? textCorrecao;
  final String? textReplica;
  final String? textTreplica;
  final String? textRFinalProfessor;
  final String? textRFinalAluno;

  final List<Arquivo>? arquivosCorrecao;
  final List<Arquivo>? arquivosReplica;
  final List<Arquivo>? arquivosTreplica;
  final List<Arquivo>? arquivosRFinalProfessor;
  final List<Arquivo>? arquivosRFinalAluno;

  final List<ProfessorBanido>? professoresBanidos;

  final String? numeroQuestoes;
  final String? softwareResposta;
  final String? valEspecifico;
  final Map<String, dynamic>? tipoArquivoResposta;

  final bool? isOrcamento;

  final List<Orcamento>? orcamentos;

  const Consulta({
    required this.id,
    required this.idNumerico,
    required this.idMateria,
    required this.idAluno,
    required this.idProfessor,
    this.idFaturalugu,
    required this.dataInicio,
    required this.timestamp,
    required this.dataFim,
    required this.descricao,
    required this.situacao,
    required this.valorConsulta,
    required this.valorProfessor,
    required this.arquivos,
    this.erroProfessor,
    this.estrelas,
    this.textCorrecao,
    this.textReplica,
    this.textTreplica,
    this.textRFinalProfessor,
    this.textRFinalAluno,
    this.arquivosCorrecao,
    this.arquivosReplica,
    this.arquivosTreplica,
    this.arquivosRFinalProfessor,
    this.arquivosRFinalAluno,
    this.professorPago,
    this.numeroQuestoes,
    this.softwareResposta,
    this.valEspecifico,
    this.tipoArquivoResposta,
    this.professoresBanidos,
    this.isOrcamento,
    this.orcamentos,
  });

  @override
  List<Object?> get props {
    return [
      id,
      idNumerico,
      idMateria,
      idAluno,
      idProfessor,
      idFaturalugu,
      dataInicio,
      timestamp,
      dataFim,
      descricao,
      situacao,
      valorConsulta,
      valorProfessor,
      arquivos,
      erroProfessor,
      estrelas,
      textCorrecao,
      textReplica,
      textTreplica,
      textRFinalProfessor,
      textRFinalAluno,
      arquivosCorrecao,
      arquivosReplica,
      arquivosTreplica,
      arquivosRFinalProfessor,
      arquivosRFinalAluno,
      professoresBanidos,
      professorPago,
      softwareResposta,
      numeroQuestoes,
      valEspecifico,
      tipoArquivoResposta,
      isOrcamento,
      orcamentos,
    ];
  }
}
