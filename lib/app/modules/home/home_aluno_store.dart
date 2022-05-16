import 'package:app_pde/app/repositories/aluno_repository.dart';
import 'package:app_pde/app/services/notification_service.dart';
import 'package:app_pde/app/shared/controllers/base_store.dart';
import 'package:app_pde/app/shared/controllers/materias_store.dart';
import 'package:app_pde/app/shared/utlis/bottom_navigation_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_aluno_store.g.dart';

class HomeAlunoStore = _HomeStoreBase with _$HomeAlunoStore;

abstract class _HomeStoreBase extends BaseStore with Store {
  final AlunoRepository _repository;
  final MateriasStore _materiasStore;

  _HomeStoreBase(this._repository, this._materiasStore);

  @observable
  int currentPageIndex = 0;

  @action
  void changePage(int index) {
    currentPageIndex = index;
    return Modular.to.navigate(allBottomNavigationRoutes[index].routeName);
  }

  @action
  Future getToken() async {
    await NotificationService().initNotification(prof: false);
    await NotificationService().permissoes();
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    await _repository.saveTokenToDatabase(token!);
    FirebaseMessaging.instance.onTokenRefresh
        .listen(_repository.saveTokenToDatabase);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    
  }

  @action
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {}

  Future<void> fetchNecessaryData() {
    return makeAsyncRequest(() => _materiasStore.fetchMaterias());
  }
}
