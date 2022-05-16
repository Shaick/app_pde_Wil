import 'package:app_pde/app/models/consulta.dart';

import 'arquivo_observable_list.dart';

enum TipoCorrecao { reclamacao, replica, treplica, finalprofessor, finalaluno }

class CorrecaoViewModel {
  final String idConsulta;
  final SituacaoConsulta situacaoConsulta;
  final String descricao;
  final bool verMessagem;
  final bool isAluno;
  final bool? erroProfessor;
  late final bool options;
  final TipoCorrecao tipoCorrecao;
  final ArquivoObservableList filesArquivos;

  CorrecaoViewModel(
      {required this.idConsulta,
      required this.situacaoConsulta,
      required this.descricao,
      required this.isAluno,
      required this.erroProfessor,
      required this.options,
      required this.verMessagem,
      required this.tipoCorrecao,
      required this.filesArquivos});

  CorrecaoViewModel copyWith(
      {String? idConsulta,
      SituacaoConsulta? situacaoConsulta,
      String? descricao,
      bool? isAluno,
      bool? erroProfessor,
      bool? options,
      bool? verMessagem,
      TipoCorrecao? tipoCorrecao,
      ArquivoObservableList? filesArquivos}) {
    return CorrecaoViewModel(
        idConsulta: idConsulta ?? '',
        situacaoConsulta: situacaoConsulta ?? this.situacaoConsulta,
        descricao: descricao ?? this.descricao,
        isAluno: isAluno ?? this.isAluno,
        erroProfessor: erroProfessor ?? this.erroProfessor,
        verMessagem: verMessagem ?? this.verMessagem,
        options: options ?? this.options,
        tipoCorrecao: tipoCorrecao ?? this.tipoCorrecao,
        filesArquivos: filesArquivos ?? this.filesArquivos);
  }

  factory CorrecaoViewModel.fromDomain(
      {required String idConsulta,
      required SituacaoConsulta situacaoConsulta,
      required String descricao,
      required bool isAluno,
      bool? erroProfessor,
      required bool options,
      required bool verMessagem,
      required TipoCorrecao tipoCorrecao,
      ArquivoObservableList? filesArquivos}) {
    return CorrecaoViewModel(
        idConsulta: idConsulta,
        situacaoConsulta: situacaoConsulta,
        descricao: descricao,
        options: options,
        isAluno: isAluno,
        erroProfessor: erroProfessor,
        tipoCorrecao: tipoCorrecao,
        verMessagem: verMessagem,
        filesArquivos: filesArquivos ?? ArquivoObservableList());
  }
}
