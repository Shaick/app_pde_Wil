import 'package:app_pde/app/models/materia.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:mobx/mobx.dart';

part 'materias_store.g.dart';

class MateriasStore = _MateriasStoreBase with _$MateriasStore;

abstract class _MateriasStoreBase with Store {
  final FirebaseRepository _repository;

  _MateriasStoreBase(this._repository);

  @observable
  ObservableList<Materia> materias = ObservableList();

  @action
  Future<List<Materia>> fetchMaterias() async {
    if (materias.isEmpty) {
      final unsortedMaterias = await _repository.getMaterias();
      unsortedMaterias.sort(
        (previous, next) => previous.nome!.compareTo(next.nome!),
      );
      materias = unsortedMaterias.asObservable();
    }
    return materias;
  }
}
