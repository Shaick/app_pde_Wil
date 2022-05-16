import 'package:app_pde/app/models/arquivo.dart';
import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/orcamento.dart';
import 'package:app_pde/app/models/professor_banido.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'correcao_view_model.dart';

class ConsultaViewModel {
  final String id;
  final String idNumerico;
  final String? idProfessor;
  final String idMateria;
  final String nomeMateria;
  final String dataInicio;
  final String dataFim;
  final int? timeStamp;
  final String hora;
  final String valor;
  final String obs;
  final String status;
  final Color? color;
  final Widget icon;
  final bool isAluno;
  final List<Arquivo> arquivos;
  final SituacaoConsulta situacao;

  final bool? erroProfessor;
  final bool? professorPago;

  final bool? verBtnPedirCorrecao;
  final bool verBtnAvalieConsulta;

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

  final String? softwareResposta;
  final String? valEspecifico;
  final Map<String?, dynamic>? tipoArquivoResposta;

  final bool? isOrcamento;

  final List<Orcamento>? orcamentos;

  const ConsultaViewModel({
    required this.id,
    required this.idMateria,
    required this.nomeMateria,
    required this.idNumerico,
    this.idProfessor,
    required this.dataInicio,
    required this.dataFim,
    required this.icon,
    required this.hora,
    required this.valor,
    required this.obs,
    required this.status,
    required this.arquivos,
    this.color,
    required this.isAluno,
    required this.situacao,
    this.erroProfessor,
    this.verBtnPedirCorrecao,
    required this.verBtnAvalieConsulta,
    this.textCorrecao,
    this.textReplica,
    this.textTreplica,
    this.timeStamp,
    this.textRFinalProfessor,
    this.textRFinalAluno,
    this.arquivosCorrecao,
    this.arquivosReplica,
    this.arquivosTreplica,
    this.arquivosRFinalProfessor,
    this.arquivosRFinalAluno,
    this.professorPago,
    this.softwareResposta,
    this.valEspecifico,
    required this.tipoArquivoResposta,
    this.professoresBanidos,
    this.isOrcamento,
    this.orcamentos,
  });

  factory ConsultaViewModel.fromDomain(Consulta consulta,
      {required String nomeMateria,
      required String idMateria,
      required String status,
      required double? valor,
      required bool isAluno,
      required Widget icon,
      required bool verBtnAvalieConsulta,
      required bool verBtnPedirCorrecao,
      SituacaoConsulta? situacao}) {
    final formattedHour = DateFormat.Hm().format(consulta.dataInicio) +
        ' – ' +
        DateFormat.Hm().format(consulta.dataFim);

    return ConsultaViewModel(
      id: consulta.id,
      idMateria: idMateria,
      nomeMateria: nomeMateria,
      idNumerico: consulta.idNumerico,
      idProfessor: consulta.idProfessor,
      dataInicio: DateFormat.MMMMd().format(consulta.dataInicio),
      dataFim: DateFormat.MMMMd().format(consulta.dataFim),
      timeStamp: consulta.dataInicio.millisecondsSinceEpoch,
      hora: formattedHour,
      valor: valor != null
          ? NumberFormat.currency(symbol: 'R\$').format(valor)
          : NumberFormat.currency(symbol: 'R\$').format(0.0),
      obs: consulta.descricao,
      status: status,
      isAluno: isAluno,
      icon: icon,
      arquivos: consulta.arquivos,
      color: // consulta.idProfessor.isNotEmpty? AppColors.success :
          AppColors.accent,
      situacao: situacao ?? consulta.situacao,
      erroProfessor: consulta.erroProfessor,
      verBtnPedirCorrecao: verBtnPedirCorrecao,
      verBtnAvalieConsulta: verBtnAvalieConsulta,
      textCorrecao: consulta.textCorrecao,
      textReplica: consulta.textReplica,
      textTreplica: consulta.textTreplica,
      textRFinalProfessor: consulta.textRFinalProfessor,
      textRFinalAluno: consulta.textRFinalAluno,
      arquivosCorrecao: consulta.arquivosCorrecao,
      arquivosReplica: consulta.arquivosReplica,
      arquivosTreplica: consulta.arquivosTreplica,
      arquivosRFinalProfessor: consulta.arquivosRFinalProfessor,
      arquivosRFinalAluno: consulta.arquivosRFinalAluno,
      professorPago: consulta.professorPago,
      professoresBanidos: consulta.professoresBanidos,
      softwareResposta: consulta.softwareResposta,
      valEspecifico: consulta.valEspecifico,
      tipoArquivoResposta: consulta.tipoArquivoResposta,
      isOrcamento: consulta.isOrcamento,
      orcamentos: consulta.orcamentos,
    );
  }

  factory ConsultaViewModel.professor(Consulta consulta,
      {required String nomeMateria, required String idMateria}) {
    String _status;

    final id = Modular.get<FirebaseAuth>().currentUser!.uid;
    SituacaoConsulta situacaoConsulta = consulta.situacao;

    if (consulta.orcamentos!.where((e) => e.idProfessor == id).isNotEmpty &&
        situacaoConsulta == SituacaoConsulta.disponiveis) {
      situacaoConsulta = SituacaoConsulta.orcadas;
    } else if (consulta.idProfessor.isEmpty) {
      situacaoConsulta = SituacaoConsulta.disponiveis;
    }

    if (situacaoConsulta == SituacaoConsulta.agendadas) {
      _status = 'Agendamento confirmado';
    } else if (situacaoConsulta == SituacaoConsulta.finalizada) {
      _status = 'Consulta finalizada';
    } else if (consulta.isOrcamento == true &&
        situacaoConsulta != SituacaoConsulta.orcadas) {
      _status = 'Aguardando orçamento';
    } else if (situacaoConsulta == SituacaoConsulta.orcadas) {
      _status = 'Já foi orçada';
    } else if (situacaoConsulta == SituacaoConsulta.pendente) {
      _status = 'Pendente Aprovação';
    } else {
      _status = 'Aguardando professor';
    }
    final verBtnPedirCorrecao = ((consulta.textCorrecao != '') &&
            (situacaoConsulta == SituacaoConsulta.andamento))
        ? true
        : false;

    return ConsultaViewModel.fromDomain(consulta,
        idMateria: idMateria,
        nomeMateria: nomeMateria,
        status: _status,
        isAluno: false,
        valor: consulta.valorProfessor,
        verBtnPedirCorrecao: verBtnPedirCorrecao,
        verBtnAvalieConsulta: false,
        icon: ((consulta.textCorrecao != '') &&
                (consulta.situacao != SituacaoConsulta.finalizada))
            ? const Icon(MdiIcons.helpCircle, color: Colors.red)
            : consulta.isOrcamento == true
                ? const Icon(Icons.monetization_on,
                    color: AppColors.monetizationIcon)
                : Container(),
        situacao: situacaoConsulta);
  }

  factory ConsultaViewModel.aluno(Consulta consulta,
      {required String nomeMateria, required String idMateria}) {
    String _status;

    if (consulta.idProfessor.isNotEmpty) {
      _status = 'Professor confirmado';
    } else if (consulta.situacao == SituacaoConsulta.finalizada) {
      _status = 'Consulta finalizada';
    } else if (consulta.isOrcamento == true &&
        consulta.situacao != SituacaoConsulta.orcadas) {
      _status = 'Aguardando orçamento';
    } else if (consulta.situacao == SituacaoConsulta.orcadas) {
      _status = 'Já foi orçada';
    } else if (consulta.situacao == SituacaoConsulta.pendente) {
      _status = 'Pendente Aprovação';
    } else {
      _status = 'Aguardando professor';
    }

    final verBtnPedirCorrecao = (((DateTime.now().isBefore(
                    consulta.dataInicio.add(const Duration(days: 15)))) &&
                (consulta.situacao == SituacaoConsulta.finalizada)) ||
            (consulta.situacao == SituacaoConsulta.andamento))
        ? true
        : false;

    final verBtnAvalieConsulta = ((DateTime.now()
                .isBefore(consulta.dataInicio.add(const Duration(days: 15)))) &&
            (consulta.situacao == SituacaoConsulta.finalizada) &&
            (consulta.estrelas == null))
        ? true
        : false;

    return ConsultaViewModel.fromDomain(consulta,
        idMateria: idMateria,
        nomeMateria: nomeMateria,
        isAluno: true,
        valor: consulta.valorConsulta,
        verBtnAvalieConsulta: verBtnAvalieConsulta,
        icon: ((verBtnPedirCorrecao) &&
                (consulta.textCorrecao != '') &&
                (consulta.situacao != SituacaoConsulta.finalizada))
            ? Icon(MdiIcons.bookArrowRight, color: Colors.amber.shade900)
            : consulta.isOrcamento == true
                ? const Icon(Icons.monetization_on, color: AppColors.primary)
                : Container(),
        status: _status,
        verBtnPedirCorrecao: verBtnPedirCorrecao);
  }

  reclamacao() {
    return CorrecaoViewModel.fromDomain(
        idConsulta: id,
        situacaoConsulta: situacao,
        descricao: textCorrecao!,
        isAluno: isAluno,
        options:
            isAluno ? ((textCorrecao == '') && (erroProfessor == null)) : false,
        verMessagem: (textCorrecao != ''),
        tipoCorrecao: TipoCorrecao.reclamacao);
  }

  replica() {
    return CorrecaoViewModel.fromDomain(
        idConsulta: id,
        situacaoConsulta: situacao,
        descricao: textReplica!,
        isAluno: isAluno,
        options: isAluno
            ? false
            : (((textCorrecao != '') && (textReplica == '')) &&
                (erroProfessor == null)),
        verMessagem: (textReplica != ''),
        tipoCorrecao: TipoCorrecao.replica);
  }

  treplica() {
    return CorrecaoViewModel.fromDomain(
        idConsulta: id,
        situacaoConsulta: situacao,
        descricao: textTreplica!,
        isAluno: isAluno,
        options: isAluno
            ? (((textCorrecao != '') &&
                    (textReplica != '') &&
                    (textTreplica == '')) &&
                (erroProfessor == null))
            : false,
        verMessagem: (textTreplica != ''),
        tipoCorrecao: TipoCorrecao.treplica);
  }

  finalProfessor() {
    return CorrecaoViewModel.fromDomain(
        idConsulta: id,
        situacaoConsulta: situacao,
        descricao: textRFinalProfessor!,
        isAluno: isAluno,
        options: isAluno
            ? false
            : (((textCorrecao != '') &&
                    (textReplica != '') &&
                    (textTreplica != '') &&
                    (textRFinalProfessor == '')) &&
                (erroProfessor == null)),
        verMessagem: (textRFinalProfessor != ''),
        tipoCorrecao: TipoCorrecao.finalprofessor);
  }

  finalAluno() {
    return CorrecaoViewModel.fromDomain(
        idConsulta: id,
        situacaoConsulta: situacao,
        descricao: textRFinalAluno!,
        isAluno: isAluno,
        options: isAluno
            ? (((textCorrecao != '') &&
                    (textReplica != '') &&
                    (textTreplica != '') &&
                    (textRFinalProfessor != '') &&
                    (textRFinalAluno == '')) &&
                (erroProfessor == null))
            : false,
        verMessagem: (textRFinalAluno != ''),
        tipoCorrecao: TipoCorrecao.finalaluno);
  }

  newItem() {
    return CorrecaoViewModel.fromDomain(
        descricao: '',
        idConsulta: id,
        isAluno: isAluno,
        options: true,
        situacaoConsulta: situacao,
        tipoCorrecao: TipoCorrecao.reclamacao,
        verMessagem: true);
  }
}
