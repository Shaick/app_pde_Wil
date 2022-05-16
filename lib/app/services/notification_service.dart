import 'dart:io';

import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications (Aluno)
late AndroidNotificationChannel channelInformeIDGerado;
late AndroidNotificationChannel channelProfesorPegouAtividade;
late AndroidNotificationChannel channelAtividadeJaTemOrcamento;
late AndroidNotificationChannel channelAtividadeSemOrcamento;
late AndroidNotificationChannel channelConsultaComeca10min;
late AndroidNotificationChannel channelAvalieConsulta;
late AndroidNotificationChannel channelProfessorRespondeuCorrecao;

/// Create a [AndroidNotificationChannel] for heads up notifications (Professor)
late AndroidNotificationChannel channelNovaConsulta;
late AndroidNotificationChannel channelOrcamentoAceito;
late AndroidNotificationChannel channelSolicitacaoCorrecao;
late AndroidNotificationChannel channelAtividadeSemProfessor;
late AndroidNotificationChannel channelConsultaComecaEm30min;
late AndroidNotificationChannel channelConsultaComecaEm5min;
late AndroidNotificationChannel channelConsultaComecou;
late AndroidNotificationChannel channelAtividadeAumentouValor;
late AndroidNotificationChannel channelMaterialApoioEditado;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initNotification({required bool prof}) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (prof) {
      await setChannelsProfessor();
    } else {
      await setChannelsAluno();
    }

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_image');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        switch (message.data['channel']) {

          ///////////////////////aluno///////////////////////

          case 'channelInformeIDGerado':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelInformeIDGerado.id,
                    channelInformeIDGerado.name,
                    //channelInformeIDGerado.description,
                  ),
                ));
            break;
          case 'channelProfesorPegouAtividade':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelProfesorPegouAtividade.id,
                    channelProfesorPegouAtividade.name,
                    //channelProfesorPegouAtividade.description,
                  ),
                ));
            break;
          case 'channelAtividadeJaTemOrcamento':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelAtividadeJaTemOrcamento.id,
                    channelAtividadeJaTemOrcamento.name,
                    //channelAtividadeJaTemOrcamento.description,
                  ),
                ));
            break;
          case 'channelAtividadeSemOrcamento':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelAtividadeSemOrcamento.id,
                    channelAtividadeSemOrcamento.name,
                    //channelAtividadeSemOrcamento.description,
                  ),
                ));
            break;
          case 'channelConsultaComeca10min':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelConsultaComeca10min.id,
                    channelConsultaComeca10min.name,
                    //channelConsultaComeca10min.description,
                  ),
                ));
            break;
          case 'channelAvalieConsulta':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelAvalieConsulta.id,
                    channelAvalieConsulta.name,
                    //channelAvalieConsulta.description,
                  ),
                ));
            break;
          case 'channelProfessorRespondeuCorrecao':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelProfessorRespondeuCorrecao.id,
                    channelProfessorRespondeuCorrecao.name,
                    //channelProfessorRespondeuCorrecao.description,
                  ),
                ));
            break;

          ///////////////////////professor///////////////////////

          case 'channelNovaConsulta':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelNovaConsulta.id,
                    channelNovaConsulta.name,
                    //channelNovaConsulta.description,
                  ),
                ));
            break;
          case 'channelOrcamentoAceito':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelOrcamentoAceito.id,
                    channelOrcamentoAceito.name,
                    //channelOrcamentoAceito.description,
                  ),
                ));
            break;
          case 'channelSolicitacaoCorrecao':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelSolicitacaoCorrecao.id,
                    channelSolicitacaoCorrecao.name,
                    //channelSolicitacaoCorrecao.description,
                  ),
                ));
            break;
          case 'channelAtividadeSemProfessor':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelAtividadeSemProfessor.id,
                    channelAtividadeSemProfessor.name,
                    //channelAtividadeSemProfessor.description,
                  ),
                ));
            break;
          case 'channelConsultaComecaEm30min':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelConsultaComecaEm30min.id,
                    channelConsultaComecaEm30min.name,
                    //channelConsultaComecaEm30min.description,
                  ),
                ));
            break;
          case 'channelConsultaComecaEm5min':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelConsultaComecaEm5min.id,
                    channelConsultaComecaEm5min.name,
                    //channelConsultaComecaEm5min.description,
                  ),
                ));
            break;
          case 'channelConsultaComecou':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelConsultaComecou.id,
                    channelConsultaComecou.name,
                    //channelConsultaComecou.description,
                  ),
                ));
            break;
          case 'channelAtividadeAumentouValor':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelAtividadeAumentouValor.id,
                    channelAtividadeAumentouValor.name,
                    //channelAtividadeAumentouValor.description,
                  ),
                ));
            break;
          case 'channelMaterialApoioEditado':
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channelMaterialApoioEditado.id,
                    channelMaterialApoioEditado.name,
                    //channelMaterialApoioEditado.description,
                  ),
                ));
            break;
        }
      }
    });
  }

  Future<void> permissoes() async {
    print('permissoes');
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  Future<void> setChannelsAluno() async {
    channelInformeIDGerado = const AndroidNotificationChannel(
      'informe_o_id_gerado', // id
      'Informe o id da consulta gerado', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelProfesorPegouAtividade = const AndroidNotificationChannel(
      'professor_pegou_sua_atividade', // id
      'Professor pegou sua atividade', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelAtividadeJaTemOrcamento = const AndroidNotificationChannel(
      'atividade_ja_tem_orcamento', // id
      'Atividade já tem orçamento', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelAtividadeSemOrcamento = const AndroidNotificationChannel(
      'atividade_ainda_sem_orcamento', // id
      'Atividade ainda sem orçamento', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelConsultaComeca10min = const AndroidNotificationChannel(
      'consulta_comeca_em_10min', // id
      'Consulta começa em 10min', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelAvalieConsulta = const AndroidNotificationChannel(
      'avalie_a_consulta', // id
      'Avalie a consulta', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelProfessorRespondeuCorrecao = const AndroidNotificationChannel(
      'professor_respondeu_sua_correcao', // id
      'Professor respondeu sua correcao', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelInformeIDGerado);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelProfesorPegouAtividade);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelAtividadeJaTemOrcamento);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelAtividadeSemOrcamento);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelConsultaComeca10min);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelAvalieConsulta);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelProfessorRespondeuCorrecao);
  }

  Future<void> setChannelsProfessor() async {
    channelNovaConsulta = const AndroidNotificationChannel(
      'nova_atividade', // id
      'Nova atividade disponível', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelOrcamentoAceito = const AndroidNotificationChannel(
      'orcamento_aceito', // id
      'Seu orcamento foi aceito', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelSolicitacaoCorrecao = const AndroidNotificationChannel(
      'solicitacao_correcao', // id
      'Aluno Solicitou correção', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelAtividadeSemProfessor = const AndroidNotificationChannel(
      'atividade_sem_professor', // id
      'Atividade ainda sem professor', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelConsultaComecaEm30min = const AndroidNotificationChannel(
      'consulta_comeca_em_30min', // id
      'Consulta começa em 30min', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelConsultaComecaEm5min = const AndroidNotificationChannel(
      'consulta_comeca_em_5min', // id
      'Consulta começa em 5min', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelConsultaComecou = const AndroidNotificationChannel(
      'consulta_comecou', // id
      'Consulta começou', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelAtividadeAumentouValor = const AndroidNotificationChannel(
      'atividade_aumentou_valor', // id
      'Atividade aumentou de valor', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    channelMaterialApoioEditado = const AndroidNotificationChannel(
      'material_de_apoio_editado', // id
      'Material de apoio editado', // title
      //'This channel is used for important notifications.',
      importance: Importance.high,
      ledColor: AppColors.accent,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelNovaConsulta);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelOrcamentoAceito);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelSolicitacaoCorrecao);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelAtividadeSemProfessor);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelConsultaComecaEm30min);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelConsultaComecaEm5min);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelConsultaComecou);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelAtividadeAumentouValor);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channelMaterialApoioEditado);
  }
}
