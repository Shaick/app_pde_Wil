// ignore_for_file: body_might_complete_normally_nullable

import 'package:app_pde/app/models/dtos/orcamento_dto.dart';
import 'package:app_pde/app/models/dtos/professor_banido_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/dtos/arquivo_dto.dart';

part 'consulta_dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ConsultaDTO {
  @JsonKey(ignore: true)
  final String? id;
  @JsonKey(name: 'IDNumerico')
  final int? idNumerico;
  @JsonKey(name: 'IDMateria')
  final String idMateria;
  @JsonKey(name: 'IDAluno')
  final String idAluno;
  @JsonKey(name: 'IDProfessor')
  final String? idProfessor;

  final String? idFaturalugu;

  @JsonKey(name: 'Descricao')
  final String descricao;

  @JsonKey(ignore: true)
  final SituacaoConsulta? situacao;

  @JsonKey(name: 'TSInicio')
  final int dataInicio;
  @JsonKey(name: 'TSFim')
  final int dataFim;
  @JsonKey(name: 'TSCriacao')
  final int timestamp;

  @JsonKey(name: 'ValorConsulta')
  final double? valorConsulta;
  @JsonKey(name: 'ValorProfessor')
  final double? valorProfessor;

  @JsonKey(name: 'ArquivosApoio', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivos;

  @JsonKey(name: 'ErroProfessor')
  final bool? erroProfessor;

  @JsonKey(name: 'Estrelas')
  final int? estrelas;

  @JsonKey(name: 'ProfPago')
  final bool? professorPago;

  @JsonKey(name: 'TextCorrecao')
  final String? textCorrecao;
  @JsonKey(name: 'TextReplica')
  final String? textReplica;
  @JsonKey(name: 'TextTreplica')
  final String? textTreplica;
  @JsonKey(name: 'TextRFinalProfessor')
  final String? textRFinalProfessor;
  @JsonKey(name: 'TextRFinalAluno')
  final String? textRFinalAluno;

  @JsonKey(name: 'ArquivosCorrecao', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivosCorrecao;
  @JsonKey(name: 'ArquivosReplica', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivosReplica;
  @JsonKey(name: 'ArquivosTreplica', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivosTreplica;
  @JsonKey(name: 'ArquivosRFinalProfessor', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivosRFinalProfessor;
  @JsonKey(name: 'ArquivosRFinalAluno', fromJson: convertArquivosFromJson)
  final List<ArquivoDTO>? arquivosRFinalAluno;

  @JsonKey(name: 'ProfessoresBanidos', fromJson: convertProfessorBanidoFromJson)
  final List<ProfessorBanidoDTO>? professoresBanidos;

  @JsonKey(name: 'NumeroQuestoes')
  final String? numeroQuestoes;
  @JsonKey(name: 'SoftwareResposta')
  final String? softwareResposta;
  @JsonKey(name: 'ValEspecifico')
  final String? valEspecifico;
  @JsonKey(name: 'TipoArquivoResposta')
  final Map<String, dynamic>? tipoArquivoResposta;
  @JsonKey(name: 'IsOrcamento')
  final bool? isOrcamento;
  @JsonKey(name: 'Orcamentos', fromJson: convertOrcamentoFromJson)
  final List<OrcamentoDTO>? orcamentos;

  const ConsultaDTO({
    this.id,
    this.idNumerico,
    required this.idMateria,
    required this.idAluno,
    this.idProfessor,
    this.idFaturalugu,
    required this.dataInicio,
    required this.timestamp,
    required this.dataFim,
    required this.descricao,
    this.situacao,
    this.valorConsulta,
    this.estrelas,
    this.valorProfessor,
    this.arquivos,
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
    this.erroProfessor,
    this.professorPago,
    this.professoresBanidos,
    this.numeroQuestoes,
    this.softwareResposta,
    this.valEspecifico,
    this.tipoArquivoResposta,
    this.isOrcamento,
    this.orcamentos,
  });

  static List<ArquivoDTO>? convertArquivosFromJson(Map? json) {
    if (json != null)
      return json.entries
          .map((e) => ArquivoDTO.fromJson(e.value).copyWith(id: e.key))
          .toList();
  }

  static List<ProfessorBanidoDTO>? convertProfessorBanidoFromJson(Map? json) {
    if (json != null)
      return json.entries
          .map((e) => ProfessorBanidoDTO(id: e.key, banido: e.value))
          .toList();
  }

  static List<OrcamentoDTO>? convertOrcamentoFromJson(Map? json) {
    if (json != null)
      return json.entries
          .map((e) => OrcamentoDTO.fromJson(e.value).copyWith(id: e.key))
          .toList();
  }

  factory ConsultaDTO.fromJson(Map json) => _$ConsultaDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ConsultaDTOToJson(this);

  Consulta toDomain() {
    return Consulta(
      id: id ?? '',
      idNumerico: idNumerico.toString(),
      idMateria: idMateria,
      idAluno: idAluno,
      idProfessor: idProfessor ?? '',
      dataInicio: DateTime.fromMillisecondsSinceEpoch(dataInicio),
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
      dataFim: DateTime.fromMillisecondsSinceEpoch(dataFim),
      descricao: descricao,
      situacao: situacao ?? SituacaoConsulta.pendente,
      valorConsulta: valorConsulta,
      valorProfessor: valorProfessor ?? 0,
      arquivos: arquivos?.map((e) => e.toDomain()).toList() ?? [],
      textCorrecao: textCorrecao ?? '',
      textReplica: textReplica ?? '',
      textTreplica: textTreplica ?? '',
      textRFinalProfessor: textRFinalProfessor ?? '',
      textRFinalAluno: textRFinalAluno ?? '',
      erroProfessor: erroProfessor,
      estrelas: estrelas,
      arquivosCorrecao:
          arquivosCorrecao?.map((e) => e.toDomain()).toList() ?? [],
      arquivosReplica: arquivosReplica?.map((e) => e.toDomain()).toList() ?? [],
      arquivosTreplica:
          arquivosTreplica?.map((e) => e.toDomain()).toList() ?? [],
      arquivosRFinalAluno:
          arquivosRFinalAluno?.map((e) => e.toDomain()).toList() ?? [],
      arquivosRFinalProfessor:
          arquivosRFinalProfessor?.map((e) => e.toDomain()).toList() ?? [],
      professoresBanidos:
          professoresBanidos?.map((e) => e.toDomain()).toList() ?? [],
      professorPago: professorPago ?? false,
      tipoArquivoResposta: tipoArquivoResposta ?? null,
      valEspecifico: valEspecifico ?? '',
      softwareResposta: softwareResposta ?? '',
      numeroQuestoes: numeroQuestoes ?? '',
      isOrcamento: isOrcamento ?? false,
      orcamentos: orcamentos?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  factory ConsultaDTO.fromDomain(Consulta model) {
    return ConsultaDTO(
      id: model.id,
      idProfessor: model.idProfessor,
      idFaturalugu: model.idFaturalugu,
      idNumerico: int.tryParse(model.idNumerico),
      idMateria: model.idMateria,
      idAluno: model.idAluno,
      dataInicio: model.dataInicio.millisecondsSinceEpoch,
      timestamp: model.timestamp.millisecondsSinceEpoch,
      dataFim: model.dataFim.millisecondsSinceEpoch,
      descricao: model.descricao,
      valorConsulta: model.valorConsulta,
      arquivos: model.arquivos.map((e) => ArquivoDTO.fromDomain(e)).toList(),
      valorProfessor: model.valorProfessor,
      situacao: model.situacao,
      estrelas: model.estrelas,
      arquivosCorrecao:
          model.arquivosCorrecao?.map((e) => ArquivoDTO.fromDomain(e)).toList(),
      arquivosReplica:
          model.arquivosReplica?.map((e) => ArquivoDTO.fromDomain(e)).toList(),
      arquivosTreplica:
          model.arquivosTreplica?.map((e) => ArquivoDTO.fromDomain(e)).toList(),
      professoresBanidos: model.professoresBanidos
          ?.map((e) => ProfessorBanidoDTO.fromDomain(e))
          .toList(),
      professorPago: model.professorPago,
      tipoArquivoResposta: model.tipoArquivoResposta,
      numeroQuestoes: model.numeroQuestoes,
      softwareResposta: model.softwareResposta,
      valEspecifico: model.valEspecifico,
      isOrcamento: model.isOrcamento,
      orcamentos:
          model.orcamentos?.map((e) => OrcamentoDTO.fromDomain(e)).toList(),
    );
  }

  ConsultaDTO copyWith({
    String? id,
    int? idNumerico,
    String? idMateria,
    String? idAluno,
    String? idProfessor,
    String? idFaturalugu,
    String? descricao,
    SituacaoConsulta? situacao,
    int? dataInicio,
    int? dataFim,
    int? timestamp,
    bool? erroProfessor,
    int? estrelas,
    double? valorConsulta,
    double? valorProfessor,
    List<ArquivoDTO>? arquivos,
    List<ArquivoDTO>? arquivosCorrecao,
    List<ArquivoDTO>? arquivosReplica,
    List<ArquivoDTO>? arquivosTreplica,
    List<ArquivoDTO>? arquivosRFinalAluno,
    List<ArquivoDTO>? arquivosRFinalProfessor,
    List<ProfessorBanidoDTO>? professoresBanidos,
    bool? professorPago,
    Map<String, bool>? tipoArquivoResposta,
    String? numeroQuestoes,
    String? softwareResposta,
    String? valEspecifico,
    bool? isOrcamento,
    List<OrcamentoDTO>? orcamento,
  }) {
    return ConsultaDTO(
      id: id ?? this.id,
      idNumerico: idNumerico ?? this.idNumerico,
      idMateria: idMateria ?? this.idMateria,
      idAluno: idAluno ?? this.idAluno,
      idProfessor: idProfessor ?? this.idProfessor,
      idFaturalugu: idFaturalugu ?? this.idFaturalugu,
      descricao: descricao ?? this.descricao,
      situacao: situacao ?? this.situacao,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      timestamp: timestamp ?? this.timestamp,
      valorConsulta: valorConsulta ?? this.valorConsulta,
      valorProfessor: valorProfessor ?? this.valorProfessor,
      arquivos: arquivos ?? this.arquivos,
      erroProfessor: erroProfessor ?? this.erroProfessor,
      estrelas: estrelas ?? this.estrelas,
      textCorrecao: textCorrecao ?? this.textCorrecao,
      textReplica: textReplica ?? this.textReplica,
      textTreplica: textTreplica ?? this.textTreplica,
      textRFinalProfessor: textRFinalProfessor ?? this.textRFinalProfessor,
      textRFinalAluno: textRFinalAluno ?? this.textRFinalAluno,
      arquivosCorrecao: arquivosCorrecao ?? this.arquivosCorrecao,
      arquivosReplica: arquivosReplica ?? this.arquivosReplica,
      arquivosTreplica: arquivosTreplica ?? this.arquivosTreplica,
      arquivosRFinalAluno: arquivosRFinalAluno ?? this.arquivosRFinalAluno,
      arquivosRFinalProfessor:
          arquivosRFinalProfessor ?? this.arquivosRFinalProfessor,
      professorPago: professorPago ?? this.professorPago,
      professoresBanidos: professoresBanidos ?? this.professoresBanidos,
      tipoArquivoResposta: tipoArquivoResposta ?? this.tipoArquivoResposta,
      numeroQuestoes: numeroQuestoes ?? this.numeroQuestoes,
      softwareResposta: softwareResposta ?? this.softwareResposta,
      valEspecifico: valEspecifico ?? this.valEspecifico,
      isOrcamento: isOrcamento ?? this.isOrcamento,
      orcamentos: orcamento ?? this.orcamentos,
    );
  }
}
