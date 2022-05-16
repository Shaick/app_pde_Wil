// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materias_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MateriasStore on _MateriasStoreBase, Store {
  final _$materiasAtom = Atom(name: '_MateriasStoreBase.materias');

  @override
  ObservableList<Materia> get materias {
    _$materiasAtom.reportRead();
    return super.materias;
  }

  @override
  set materias(ObservableList<Materia> value) {
    _$materiasAtom.reportWrite(value, super.materias, () {
      super.materias = value;
    });
  }

  final _$fetchMateriasAsyncAction =
      AsyncAction('_MateriasStoreBase.fetchMaterias');

  @override
  Future<List<Materia>> fetchMaterias() {
    return _$fetchMateriasAsyncAction.run(() => super.fetchMaterias());
  }

  @override
  String toString() {
    return '''
materias: ${materias}
    ''';
  }
}
