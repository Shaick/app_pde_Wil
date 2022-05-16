import 'package:app_pde/app/modules/cadastro_consulta_aluno/cadastro_consulta_aluno_store.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/revisao_page/revisao_consulta_aluno_page.dart';
import 'package:app_pde/app/modules/home/chats/chat_download_store.dart';
import 'package:app_pde/app/modules/home/home_page.dart';
import 'package:app_pde/app/modules/home/user_account/edit_user_page.dart';
import 'package:app_pde/app/modules/home/user_account/user_account_page.dart';
import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/modules/login/widgets/login_reject_page.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_page.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/detalhes_consulta_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/minhas_consultas_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/correcao_consulta/correcao_consulta_page.dart';
import 'package:app_pde/app/modules/professor/correcao_consulta/correcao_consulta_store.dart';
import 'package:app_pde/app/repositories/aluno_repository.dart';
import 'package:app_pde/app/shared/controllers/drawer_store.dart';
import 'package:app_pde/app/shared/utlis/bottom_navigation_routes.dart';
import 'package:app_pde/app/shared/utlis/chat_file_uploader.dart';
import 'package:app_pde/app/shared/utlis/download_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_aluno_store.dart';
import 'chats/all_chats_page.dart';
import 'chats/all_chats_store.dart';
import 'chats/current_chat_page.dart';
import 'chats/current_chat_store.dart';
import 'chats/view_models/chat_view_model.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeAlunoStore(i.get(), i.get())),
    Bind.lazySingleton((i) => AlunoRepository(i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => MinhasConsultasStore(i.get(), i.get())),
    Bind.lazySingleton((i) => CadastroConsultaAlunoStore(
        i.get(), i.get(), i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => UserAccountStore(i.get(), i.get(), true)),
    Bind.lazySingleton((i) => DrawerStore(true)),
    Bind.lazySingleton((i) => AllChatsStore(i.get(), i.get(), i.get(), true)),
    Bind.lazySingleton(
        (i) => CurrentChatStore(i.get(), i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => ChatFileUploader(i.get())),
    Bind.lazySingleton((i) => ChatDownloadStore(i.get())),
    Bind.lazySingleton((i) => DetalhesConsultaStore(i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => CorrecaoConsultaStore(i.get(), i.get(), i.get())),
    Bind.factory((i) => DownloadService()),
    Bind.lazySingleton((i) => FirebaseStorage.instance),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: allBottomNavigationRoutes
          .map((route) => ChildRoute(
                route.routeName,
                child: (_, args) => route.child,
                transition: TransitionType.fadeIn,
              ))
          .toList(),
    ),
    ChildRoute(
      '/minhas-consultas/:id/detalhes',
      child: (_, args) => DetalhesConsultaPage(args.data as ConsultaViewModel),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute(
      '/cadastrar-consulta/revisao',
      child: (_, args) => const RevisaoConsultaPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute('/minha-conta', child: (_, args) => UserAccountPage()),
    ChildRoute(
      '/minha-conta/edit',
      child: (_, args) => const EditUserPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute('/mensagens',
        child: (_, args) => const AllChatsPage(),
        transition: TransitionType.rightToLeftWithFade),
    ChildRoute(
      '/mensagens/:id/chat',
      child: (_, args) => CurrentChatPage(args.data as ChatViewModel),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute('/consultas/:id/correcao',
        child: (_, args) =>
            CorrecaoConsultaPage(args.data as ConsultaViewModel)),
    ChildRoute(
      '/LoginReject',
      child: (_, args) => const LoginRejectPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
  ];
}
