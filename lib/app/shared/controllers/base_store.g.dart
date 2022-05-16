// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_BaseStore.hasError'))
      .value;

  final _$errorMessageAtom = Atom(name: '_BaseStore.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$loadingAtom = Atom(name: '_BaseStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$makeAsyncRequestAsyncAction =
      AsyncAction('_BaseStore.makeAsyncRequest');

  @override
  Future<T?> makeAsyncRequest<T>(Future<T> Function() function) {
    return _$makeAsyncRequestAsyncAction
        .run(() => super.makeAsyncRequest<T>(function));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
loading: ${loading},
hasError: ${hasError}
    ''';
  }
}
