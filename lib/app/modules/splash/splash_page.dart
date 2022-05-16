import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './widgets/retry_connection_page.dart';
import 'splash_store.dart';

class SplashPage extends StatefulWidget {
  final String title;

  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashStore> {
  @override
  void initState() {
    super.initState();
    controller.initializeLoginDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.checkConnection(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return const RetryConnectionPage();
      },
    );
  }
}
