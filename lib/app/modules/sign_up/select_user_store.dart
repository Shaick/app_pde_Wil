import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'select_user_store.g.dart';

class SelectUserStore = _SelectUserStoreBase with _$SelectUserStore;

abstract class _SelectUserStoreBase with Store {

  late int claim;

  @action
  void setAluno() {
    claim = 0;
    setRoute();
  }

  @action
  void setProfessor()  {
    claim = 4;
    setRoute();
  }

  void setRoute() {Modular.to.pushNamed('/sign-up'); }
  
}
