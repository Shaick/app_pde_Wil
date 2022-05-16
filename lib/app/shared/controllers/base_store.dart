import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:app_pde/app/shared/errors/mesage_reset.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  String? errorMessage;

  @computed
  bool get hasError => errorMessage != null;

  @observable
  bool loading = false;

  @action
  // ignore: body_might_complete_normally_nullable
  Future<T?> makeAsyncRequest<T>(Future<T> Function() function) async {
    loading = true;
    try {
      final result = await function();
      return result;
    } on Failure catch (e) {
      errorMessage = strError(e.message) ?? e.message;
    } on FirebaseFunctionsException catch (e) {
      errorMessage = mapErrorFunction['${e.message}']!;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
    }
  }
}
