import 'package:app_pde/app/modules/login/login_store.dart';
import 'package:app_pde/app/modules/login/reset_password/reset_page.dart';
import 'package:app_pde/app/modules/login/reset_password/reset_store.dart';
import 'package:app_pde/app/modules/sign_up/sign_up_page.dart';
import 'package:app_pde/app/modules/sign_up/sign_up_store.dart';
import 'package:app_pde/app/modules/sign_up/terms_of_use/terms_of_use_page.dart';
import 'package:app_pde/app/repositories/auth_repository.dart';
import 'package:app_pde/app/repositories/chat_repository.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/controllers/materias_store.dart';
import 'package:app_pde/app/shared/utlis/biometric_authentication.dart';
import 'package:app_pde/app/shared/utlis/user_secure_storage.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'modules/home/home_module.dart';
import 'modules/login/login_page.dart';
import 'modules/professor/professor_module.dart';
import 'modules/sign_up/select_user_page.dart';
import 'modules/sign_up/select_user_store.dart';
import 'modules/splash/splash_page.dart';
import 'modules/splash/splash_store.dart';
import 'modules/upload_file/upload_file_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore(i.get())),
    Bind.lazySingleton((i) => MateriasStore(i.get())),
    Bind.lazySingleton((i) => LoginStore(i.get(), i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => SignUpStore(i.get())),
    Bind.lazySingleton((i) => ResetStore()),
    Bind.lazySingleton((i) => AuthController(i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => BiometricAuthentication()),
    Bind.lazySingleton((i) => FirebaseRepository(i.get(), i.get())),
    Bind.lazySingleton((i) => AuthRepository(i.get(), i.get())),
    Bind.lazySingleton((i) => UserSecureStorage(i.get())),
    Bind.lazySingleton((i) => SelectUserStore()),
    Bind.lazySingleton((i) => const FlutterSecureStorage()),
    Bind.lazySingleton((i) => FirebaseDatabase.instance),
    Bind.lazySingleton(
        (i) => FirebaseFunctions.instanceFor(region: 'us-central1')),
    Bind.lazySingleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton((i) => UploadFileStore()),
    Bind.lazySingleton((i) => ChatRepository(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
    ChildRoute('/login', child: (_, args) => const LoginPage()),
    ChildRoute('/sign-up/select-user',
        child: (_, args) => const SelectUserPage()),
    ChildRoute(
      '/sign-up',
      child: (_, args) => const SignUpPage(),
    ),
    ChildRoute(
      '/sign-up/terms-of-use',
      child: (_, args) => TermsOfUsePage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute(
      '/reset-password',
      child: (_, args) => ResetPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/professor',
      module: ProfessorModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
