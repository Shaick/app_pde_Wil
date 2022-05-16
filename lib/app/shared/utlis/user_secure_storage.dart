import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorageCredentials {
  final String email;
  final String? password;

  const UserStorageCredentials({required this.email, this.password});
}

class UserSecureStorage {
  final FlutterSecureStorage _storage;

  const UserSecureStorage(this._storage);

  String get emailKey => 'email';
  String get passwordKey => 'password';
  String get biometricAuthKey => 'biometricAuth';

  // ignore: body_might_complete_normally_nullable
  Future<UserStorageCredentials?> getUserCredentials() async {
    final email = await _storage.read(key: emailKey);
    final password = await _storage.read(key: passwordKey);
    if (email != null || password != null) {
      return UserStorageCredentials(email: '$email', password: '$password');
    }
  }

  Future<void> saveUserPassword(UserStorageCredentials credentials) async {
    await _storage.write(key: passwordKey, value: credentials.password);
  }

  Future<void> saveUserEmail(UserStorageCredentials credentials) async {
    await _storage.write(key: emailKey, value: credentials.email);
  }

  Future<bool> userCredentialsExist() async {
    final emailExists = await _storage.containsKey(key: emailKey);
    final passwordExists = await _storage.containsKey(key: passwordKey);
    return (emailExists && passwordExists);
  }

  Future<void> clearStorageEmail() => _storage.delete(key: emailKey);

  Future<void> clearStoragePassword() => _storage.delete(key: passwordKey);

  Future<void> saveBiometricAuthPreferences(bool isOn) {
    return _storage.write(key: biometricAuthKey, value: isOn.toString());
  }

  Future<bool> isBiometricAuthActive() async {
    final preferences = await _storage.read(key: biometricAuthKey);
    return preferences?.toLowerCase() == 'true';
  }
}
