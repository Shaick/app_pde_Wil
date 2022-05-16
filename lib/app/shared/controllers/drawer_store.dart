import 'package:mobx/mobx.dart';

part 'drawer_store.g.dart';

class DrawerStore = _DrawerStoreBase with _$DrawerStore;

abstract class _DrawerStoreBase with Store {
  final bool menuAlunoOrProfessor;

  _DrawerStoreBase(this.menuAlunoOrProfessor);

  @observable
  int currentItemIndex = 0;

  @action
  void selectItem(int index) => currentItemIndex = index;
}
