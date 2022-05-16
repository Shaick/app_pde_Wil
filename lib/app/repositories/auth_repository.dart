import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:app_pde/app/shared/errors/mesage_reset.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFunctions functions;

  const AuthRepository(this._firebaseAuth, this.functions);

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.toString();
      throw Failure(errorMessage);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      return _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final message = mapError['${e.code}'];
      throw Failure(message!);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String telefone,
      required claim,
      required terms}) async {
    try {
      var dto;

      if (claim == 4) {
        dto = {
          'ChavePix': '',
          'Claim': claim,
          'Telefone': '+$telefone',
          'Email': email,
          'Senha': password,
          'TermosAceitos': terms
        };
        await functions.httpsCallable('createUser').call(dto);
        await Modular.to.pushNamed('home/LoginReject');
      } else {
        dto = {
          'Claim': claim,
          'Telefone': '+$telefone',
          'Email': email,
          'Senha': password,
          'TermosAceitos': terms
        };
        await functions.httpsCallable('createUser').call(dto);
      }

      // await signInWithEmailAndPassword(email: email, password:password);
    } on FirebaseFunctionsException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      final errorMessage = e.toString();
      throw Failure(errorMessage);
    }
  }

  Stream<bool> isUserAuthenticated() {
    return _firebaseAuth.userChanges().map((user) => user != null);
  }
}
