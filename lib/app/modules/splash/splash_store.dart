import 'package:app_pde/app/modules/login/login_store.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final LoginStore _loginStore;

  _SplashStoreBase(this._loginStore);

  @observable
  String status = '';

  @action
  Future<void> checkConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        status = '';
      } else {
        status = 'Erro na Conexão!!!..';
      }
    } catch (e) {

    }
  }

  Future<void> initializeLoginDependencies() {
    return Future.delayed(const Duration(seconds: 2))
        .then((_) => Firebase.initializeApp())
        .then((_) => Modular.to.navigate('/login'))
        .then((_) => _loginStore.init());
  }
}
