import 'package:app_pde/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void buildFlavors(Flavor flavor) async {
  F.appFlavor = flavor;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true);
  Intl.defaultLocale = 'pt_BR';
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
