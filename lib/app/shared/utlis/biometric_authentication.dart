import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricAuthentication {
  final _localAuth = LocalAuthentication();

  Future<bool> tryAuthentication() async {
    try {
      final result = await _localAuth.authenticate(
          localizedReason: "Use a biometria para prosseguir",
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
                signInTitle: 'Biometria para login do Aplicativo',
                cancelButton: 'Cancelar'),
            IOSAuthMessages(cancelButton: 'Cancelar'),
          ],
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: true, stickyAuth: true));
      return result;
    } on PlatformException catch (e) {
      print(e);
      throw const Failure('Falha na biometria');
    } catch (e) {
      print(e);
      throw const Failure('Falha desconhecida');
    }
  }

  Future<bool> isAvailable() async {
    if (await _localAuth.canCheckBiometrics &&
        await _localAuth.isDeviceSupported()) {
      final listOfBiometrics = await _localAuth.getAvailableBiometrics();
      return listOfBiometrics.contains(BiometricType.fingerprint);
    }
    return false;
  }
}
