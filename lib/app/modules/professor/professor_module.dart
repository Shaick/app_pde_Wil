import 'package:app_pde/app/modules/home/chats/all_chats_page.dart';
import 'package:app_pde/app/modules/home/chats/all_chats_store.dart';
import 'package:app_pde/app/modules/home/chats/chat_download_store.dart';
import 'package:app_pde/app/modules/home/chats/current_chat_page.dart';
import 'package:app_pde/app/modules/home/chats/current_chat_store.dart';
import 'package:app_pde/app/modules/home/chats/view_models/chat_view_model.dart';
import 'package:app_pde/app/modules/home/user_account/edit_user_page.dart';
import 'package:app_pde/app/modules/home/user_account/user_account_page.dart';
import 'package:app_pde/app/modules/home/user_account/user_account_store.dart';
import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/financeiro/financeiro_professor_page.dart';
import 'package:app_pde/app/modules/professor/financeiro/financeiro_professor_store.dart';
import 'package:app_pde/app/modules/professor/orcamento/orcamento_professor_page.dart';
import 'package:app_pde/app/modules/professor/professor_page.dart';
import 'package:app_pde/app/modules/professor/professor_store.dart';
import 'package:app_pde/app/repositories/professor_repository.dart';
import 'package:app_pde/app/shared/controllers/drawer_store.dart';
import 'package:app_pde/app/shared/utlis/chat_file_uploader.dart';
import 'package:app_pde/app/shared/utlis/download_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'correcao_consulta/correcao_consulta_page.dart';
import 'correcao_consulta/correcao_consulta_store.dart';
import 'detalhe_consulta/detalhes_consulta_professor_page.dart';
import 'detalhe_consulta/detalhes_consulta_professor_store.dart';
import 'orcamento/orcamento_professor_store.dart';

class ProfessorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfessorStore(i.get(), i.get())),
    Bind.lazySingleton((i) => UserAccountStore(i.get(), i.get(), false)),
    Bind.lazySingleton((i) => DrawerStore(false)),
    Bind.lazySingleton((i) => AllChatsStore(i.get(), i.get(), i.get(), false)),
    Bind.lazySingleton(
        (i) => CurrentChatStore(i.get(), i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => ChatFileUploader(i.get())),
    Bind.lazySingleton((i) => ChatDownloadStore(i.get())),
    Bind.lazySingleton((i) => DetalhesConsultaProfessorStore(
          i.get(),
          i.get(),
          i.get(),
          i.get(),
          i.get(),
        )),
    Bind.lazySingleton((i) => CorrecaoConsultaStore(i.get(), i.get(), i.get())),
    Bind.factory((i) => DownloadService()),
    Bind.lazySingleton(
        (i) => FinanceiroProfessorStore(i.get(), i.get(), i.get())),
    Bind.lazySingleton((i) => ProfessorRepository(i.get(), i.get(), i.get())),
    Bind.lazySingleton(
        (i) => OrcamentoProfessorStore(i.get(), i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const ProfessorPage()),
    ChildRoute('/consultas/:id/detalhes',
        child: (_, args) =>
            DetalhesConsultaProfessorPage(args.data as ConsultaViewModel),
        transition: TransitionType.rightToLeftWithFade),
    ChildRoute('/minha-conta', child: (_, args) => UserAccountPage()),
    ChildRoute('/minha-conta/edit', child: (_, args) => const EditUserPage()),
    ChildRoute('/mensagens', child: (_, args) => const AllChatsPage()),
    ChildRoute('/mensagens/:id/chat',
        child: (_, args) => CurrentChatPage(args.data as ChatViewModel),
        transition: TransitionType.rightToLeftWithFade),
    ChildRoute(
      '/consultas/:id/correcao',
      child: (_, args) => CorrecaoConsultaPage(args.data as ConsultaViewModel),
    ),
    ChildRoute('/financeiro',
        child: (_, args) => const FinanceiroProfessorPage()),
    ChildRoute('/consultas/:id/orcamento',
        child: (_, args) =>
            OrcamentoProfessorPage(args.data as ConsultaViewModel)),
  ];
}
