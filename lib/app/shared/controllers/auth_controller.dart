import 'package:app_pde/app/models/aluno.dart';
import 'package:app_pde/app/models/professor.dart';
import 'package:app_pde/app/models/usuario.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../repositories/auth_repository.dart';

class AuthController {
  final FirebaseRepository _repository;
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  AuthController(this._repository, this._authRepository, this._firebaseAuth);

  //void _popPage() => Modular.to.pop();

  Usuario? _user;
  Usuario? get user => _user;

  Future<Usuario?> fetchCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      _user = await _repository.getUser();
    }
    return user;
  }

  Future<dynamic> createUser(int claim, String email, String password,
      String telefone, bool terms) async {
    await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        telefone: telefone,
        claim: claim,
        terms: terms);
    resolveLoggedInUser();
  }

  Future<void> resetUserCredentials(String email) =>
      _authRepository.sendPasswordResetEmail(email: email);

  Future<void> userLogout() {
    _user = null;
    Modular.to.pushReplacementNamed('/');
    return _firebaseAuth.signOut();
  }

  void resolveLoggedInUser() {
    fetchCurrentUser().then((_) {
      _authRepository.isUserAuthenticated().listen((event) {
        event ? _navigateLoggedInUser() : _navigateLoggedOutUser();
      });
    });
  }

  _navigateLoggedInUser() {
    if (user is Aluno) {
      return Modular.to.navigate('/home/minhas-consultas', arguments: user);
    } else if (user is Professor) {
      if (user!.idPermissao == 'null') {
        return Modular.to.navigate('home/LoginReject');
      } else {
        return Modular.to.navigate('/professor');
      }
    } else {
      return _navigateLoggedOutUser();
    }
  }

  void _navigateLoggedOutUser() => Modular.to.navigate('/login');
}
