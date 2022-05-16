// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulta_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsultaDTO _$ConsultaDTOFromJson(Map json) => ConsultaDTO(
      idNumerico: json['IDNumerico'] as int?,
      idMateria: json['IDMateria'] as String,
      idAluno: json['IDAluno'] as String,
      idProfessor: json['IDProfessor'] as String?,
      idFaturalugu: json['idFaturalugu'] as String?,
      dataInicio: json['TSInicio'] as int,
      timestamp: json['TSCriacao'] as int,
      dataFim: json['TSFim'] as int,
      descricao: json['Descricao'] as String,
      valorConsulta: (json['ValorConsulta'] as num?)?.toDouble(),
      estrelas: json['Estrelas'] as int?,
      valorProfessor: (json['ValorProfessor'] as num?)?.toDouble(),
      arquivos:
          ConsultaDTO.convertArquivosFromJson(json['ArquivosApoio'] as Map?),
      textCorrecao: json['TextCorrecao'] as String?,
      textReplica: json['TextReplica'] as String?,
      textTreplica: json['TextTreplica'] as String?,
      textRFinalProfessor: json['TextRFinalProfessor'] as String?,
      textRFinalAluno: json['TextRFinalAluno'] as String?,
      arquivosCorrecao:
          ConsultaDTO.convertArquivosFromJson(json['ArquivosCorrecao'] as Map?),
      arquivosReplica:
          ConsultaDTO.convertArquivosFromJson(json['ArquivosReplica'] as Map?),
      arquivosTreplica:
          ConsultaDTO.convertArquivosFromJson(json['ArquivosTreplica'] as Map?),
      arquivosRFinalProfessor: ConsultaDTO.convertArquivosFromJson(
          json['ArquivosRFinalProfessor'] as Map?),
      arquivosRFinalAluno: ConsultaDTO.convertArquivosFromJson(
          json['ArquivosRFinalAluno'] as Map?),
      erroProfessor: json['ErroProfessor'] as bool?,
      professorPago: json['ProfPago'] as bool?,
      professoresBanidos: ConsultaDTO.convertProfessorBanidoFromJson(
          json['ProfessoresBanidos'] as Map?),
      numeroQuestoes: json['NumeroQuestoes'] as String?,
      softwareResposta: json['SoftwareResposta'] as String?,
      valEspecifico: json['ValEspecifico'] as String?,
      tipoArquivoResposta: (json['TipoArquivoResposta'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      ),
      isOrcamento: json['IsOrcamento'] as bool?,
      orcamentos:
          ConsultaDTO.convertOrcamentoFromJson(json['Orcamentos'] as Map?),
    );

Map<String, dynamic> _$ConsultaDTOToJson(ConsultaDTO instance) =>
    <String, dynamic>{
      'IDNumerico': instance.idNumerico,
      'IDMateria': instance.idMateria,
      'IDAluno': instance.idAluno,
      'IDProfessor': instance.idProfessor,
      'idFaturalugu': instance.idFaturalugu,
      'Descricao': instance.descricao,
      'TSInicio': instance.dataInicio,
      'TSFim': instance.dataFim,
      'TSCriacao': instance.timestamp,
      'ValorConsulta': instance.valorConsulta,
      'ValorProfessor': instance.valorProfessor,
      'ArquivosApoio': instance.arquivos?.map((e) => e.toJson()).toList(),
      'ErroProfessor': instance.erroProfessor,
      'Estrelas': instance.estrelas,
      'ProfPago': instance.professorPago,
      'TextCorrecao': instance.textCorrecao,
      'TextReplica': instance.textReplica,
      'TextTreplica': instance.textTreplica,
      'TextRFinalProfessor': instance.textRFinalProfessor,
      'TextRFinalAluno': instance.textRFinalAluno,
      'ArquivosCorrecao':
          instance.arquivosCorrecao?.map((e) => e.toJson()).toList(),
      'ArquivosReplica':
          instance.arquivosReplica?.map((e) => e.toJson()).toList(),
      'ArquivosTreplica':
          instance.arquivosTreplica?.map((e) => e.toJson()).toList(),
      'ArquivosRFinalProfessor':
          instance.arquivosRFinalProfessor?.map((e) => e.toJson()).toList(),
      'ArquivosRFinalAluno':
          instance.arquivosRFinalAluno?.map((e) => e.toJson()).toList(),
      'ProfessoresBanidos':
          instance.professoresBanidos?.map((e) => e.toJson()).toList(),
      'NumeroQuestoes': instance.numeroQuestoes,
      'SoftwareResposta': instance.softwareResposta,
      'ValEspecifico': instance.valEspecifico,
      'TipoArquivoResposta': instance.tipoArquivoResposta,
      'IsOrcamento': instance.isOrcamento,
      'Orcamentos': instance.orcamentos?.map((e) => e.toJson()).toList(),
    };
