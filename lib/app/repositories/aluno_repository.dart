import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/dtos/consulta_dto.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AlunoRepository extends FirebaseRepository {
  // ignore: unused_field
  final FirebaseDatabase _db;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFunctions functions;

  AlunoRepository(FirebaseDatabase db, FirebaseAuth firebaseAuth,
      FirebaseFunctions functions)
      : _db = db,
        _firebaseAuth = firebaseAuth,
        functions = functions,
        super(db, firebaseAuth);

  Future<List<Consulta>> getConsultasFinalizadas() => _getConsultas(
        path: 'concluidas',
        situacao: SituacaoConsulta.finalizada,
      );

  Future<List<Consulta>> getConsultasAndamento() => _getConsultas(
        path: 'ativas',
        situacao: SituacaoConsulta.andamento,
      );

  Future<List<Consulta>> getConsultasPendentes() => _getConsultas(
        path: 'liberar',
        situacao: SituacaoConsulta.pendente,
      );

  Future<List<Consulta>> _getConsultas({
    required String path,
    required SituacaoConsulta situacao,
  }) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final dbEvent = await db
          .child('consultas')
          .child(path)
          .orderByChild('IDAluno')
          .equalTo(userId)
          .once();
      if (dbEvent.snapshot.value == null) return [];
      final json = Map<String, dynamic>.from(dbEvent.snapshot.value as Map);
      return json.entries.map((e) {
        final consultaDTO = ConsultaDTO.fromJson(e.value).copyWith(
          id: e.key,
          situacao: situacao,
        );
        return consultaDTO.toDomain();
      }).toList();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final user = await db.child('users').child('alunos').child(userId);
      await user.update({'token': token});
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<DatabaseReference> createConsulta(
      ConsultaDTO consultaDTO, bool isOrcamento) async {
    final incrementResult = await _incrementConsultasCounter();
    if (!incrementResult.committed) {
      throw const Failure('Erro ao salvar consulta');
    }
    final refLiberar;
    if (isOrcamento == true) {
      refLiberar = db.child('consultas').child('ativas').push();
    } else {
      refLiberar = db.child('consultas').child('liberar').push();
    }
    consultaDTO = consultaDTO.copyWith(
      idNumerico: incrementResult.snapshot.value as int,
    );

    await refLiberar.set(consultaDTO.toJson());
    return refLiberar;
  }

  Future<TransactionResult> _incrementConsultasCounter() async {
    final counterReference = db.child('consultas').child('count');
    final transactionResult = await counterReference.runTransaction((count) {
      final response = (int.parse(count?.toString() ?? '0')) + 1;
      return Transaction.success(response);
    });
    return transactionResult;
  }
/*
  Future<void> sendMessage({required String token}) async {
    try {
      String message = jsonEncode({
        'token': token,
        'title': 'teste notification',
        'body': 'teste notification sendMessage',
      });

      await functions
          .httpsCallable('notificacoes-sendNotification')
          .call(message);
    } on FirebaseFunctionsException catch (e) {
      print("error: " + e.toString());
      throw e;
    }

  }*/

  getConsultaReferencia(ConsultaDTO consulta) {
    final refLiberar;
    if (consulta.id != null) {
      if (consulta.isOrcamento == true) {
        refLiberar =
            db.child('consultas').child('ativas').child(consulta.id.toString());
      } else {
        refLiberar = db
            .child('consultas')
            .child('liberar')
            .child(consulta.id.toString());
      }
      ;
      return refLiberar;
    } else
      throw const Failure("Essa consulta não existe");
  }
}
