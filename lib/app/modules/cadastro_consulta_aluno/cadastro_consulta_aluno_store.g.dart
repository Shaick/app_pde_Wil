// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_consulta_aluno_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroConsultaAlunoStore on _CadastroConsultaAlunoStore, Store {
  final _$isSwitchedAtom = Atom(name: '_CadastroConsultaAlunoStore.isSwitched');

  @override
  bool get isSwitched {
    _$isSwitchedAtom.reportRead();
    return super.isSwitched;
  }

  @override
  set isSwitched(bool value) {
    _$isSwitchedAtom.reportWrite(value, super.isSwitched, () {
      super.isSwitched = value;
    });
  }

  final _$fotoAtom = Atom(name: '_CadastroConsultaAlunoStore.foto');

  @override
  bool get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(bool value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
    });
  }

  final _$dwgAtom = Atom(name: '_CadastroConsultaAlunoStore.dwg');

  @override
  bool get dwg {
    _$dwgAtom.reportRead();
    return super.dwg;
  }

  @override
  set dwg(bool value) {
    _$dwgAtom.reportWrite(value, super.dwg, () {
      super.dwg = value;
    });
  }

  final _$pdfAtom = Atom(name: '_CadastroConsultaAlunoStore.pdf');

  @override
  bool get pdf {
    _$pdfAtom.reportRead();
    return super.pdf;
  }

  @override
  set pdf(bool value) {
    _$pdfAtom.reportWrite(value, super.pdf, () {
      super.pdf = value;
    });
  }

  final _$xlsxAtom = Atom(name: '_CadastroConsultaAlunoStore.xlsx');

  @override
  bool get xlsx {
    _$xlsxAtom.reportRead();
    return super.xlsx;
  }

  @override
  set xlsx(bool value) {
    _$xlsxAtom.reportWrite(value, super.xlsx, () {
      super.xlsx = value;
    });
  }

  final _$docxAtom = Atom(name: '_CadastroConsultaAlunoStore.docx');

  @override
  bool get docx {
    _$docxAtom.reportRead();
    return super.docx;
  }

  @override
  set docx(bool value) {
    _$docxAtom.reportWrite(value, super.docx, () {
      super.docx = value;
    });
  }

  final _$isOrcamentoAtom =
      Atom(name: '_CadastroConsultaAlunoStore.isOrcamento');

  @override
  bool get isOrcamento {
    _$isOrcamentoAtom.reportRead();
    return super.isOrcamento;
  }

  @override
  set isOrcamento(bool value) {
    _$isOrcamentoAtom.reportWrite(value, super.isOrcamento, () {
      super.isOrcamento = value;
    });
  }

  final _$isEnabledAtom = Atom(name: '_CadastroConsultaAlunoStore.isEnabled');

  @override
  bool get isEnabled {
    _$isEnabledAtom.reportRead();
    return super.isEnabled;
  }

  @override
  set isEnabled(bool value) {
    _$isEnabledAtom.reportWrite(value, super.isEnabled, () {
      super.isEnabled = value;
    });
  }

  final _$_CadastroConsultaAlunoStoreActionController =
      ActionController(name: '_CadastroConsultaAlunoStore');

  @override
  dynamic addIsOrcamento(bool value) {
    final _$actionInfo = _$_CadastroConsultaAlunoStoreActionController
        .startAction(name: '_CadastroConsultaAlunoStore.addIsOrcamento');
    try {
      return super.addIsOrcamento(value);
    } finally {
      _$_CadastroConsultaAlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> criarConsulta() {
    final _$actionInfo = _$_CadastroConsultaAlunoStoreActionController
        .startAction(name: '_CadastroConsultaAlunoStore.criarConsulta');
    try {
      return super.criarConsulta();
    } finally {
      _$_CadastroConsultaAlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSwitched: ${isSwitched},
foto: ${foto},
dwg: ${dwg},
pdf: ${pdf},
xlsx: ${xlsx},
docx: ${docx},
isOrcamento: ${isOrcamento},
isEnabled: ${isEnabled}
    ''';
  }
}
