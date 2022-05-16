import 'package:app_pde/app/models/aluno.dart';
import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/dtos/materia_dto.dart';
import 'package:app_pde/app/models/dtos/usuario_dto.dart';
import 'package:app_pde/app/models/materia.dart';
import 'package:app_pde/app/models/usuario.dart';
import 'package:app_pde/app/modules/cadastro_consulta_aluno/widgets/custom_alert_dialog.dart';
import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRepository {
  final FirebaseDatabase _db;
  final FirebaseAuth _firebaseAuth;

  const FirebaseRepository(this._db, this._firebaseAuth);

  DatabaseReference get db => _db.ref();

  Future<Usuario?> getUser() async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      var dbEvent = await db.child('users/alunos/$userId').once();
      if (dbEvent.snapshot.value == null) {
        dbEvent = await db.child('users/professores/$userId').once();
        if (dbEvent.snapshot.value == null) {
          dbEvent = await db.child('users/professoresPendentes/$userId').once();
        }
      }
      if (dbEvent.snapshot.value != null) {
        final json = Map<String, dynamic>.from(dbEvent.snapshot.value as Map);
        final usuarioDTO =
            UsuarioDTO.fromJson(json).copyWith(id: dbEvent.snapshot.key);
        return usuarioDTO.toDomain();
      } else {
        const CustomAlertDialog(
            title: 'Usuario não liberado!',
            message: 'Usuario não cadastrado ou liberado!');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
    return null;
  }

  // Future<List<Materia>> getMateriasId(List<String> materiasId) async {
  //   try {
  //     final List<Materia> result = [];
  //     materiasId.map((e) async {
  //       final snapshot = await db.child('materias/$e').once();
  //       final materiaDTO =
  //           MateriaDTO.fromJson(snapshot.value).copyWith(id: snapshot.key);
  //       result.add(materiaDTO.toDomain());
  //     });
  //     return result;
  //   } catch (e) {
  //     print(e);
  //     throw Failure(e.toString());
  //   }
  // }

  Future<List<Materia>> getMaterias() async {
    try {
      final dbEvent = await db.child('materias').once();
      final json = Map<String, dynamic>.from(dbEvent.snapshot.value as Map);
      return json.entries.map((e) {
        final materiaJson = Map<String, dynamic>.from(e.value);
        final materiaDTO = MateriaDTO.fromJson(materiaJson).copyWith(id: e.key);
        return materiaDTO.toDomain();
      }).toList();
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  Future<void> updateUser(Usuario user) async {
    try {
      final path = user is Aluno ? 'users/alunos' : 'users/professores';
      final usuarioDTO = UsuarioDTO.fromDomain(user);
      final userId = _firebaseAuth.currentUser!.uid;
      return db.child(path).child(userId).update(usuarioDTO.toJson());
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  Future<void> deleteFileInsideConsulta({
    required String idArquivo,
    required String idConsulta,
    required SituacaoConsulta situacao,
  }) async {
    late String path;
    switch (situacao) {
      case SituacaoConsulta.andamento:
        path = 'ativas';
        break;
      case SituacaoConsulta.pendente:
        path = 'liberar';
        break;
      case SituacaoConsulta.finalizada:
        path = 'concluidas';
        break;
      default:
        path = 'concluidas';
    }

    try {
      return db
          .child('consultas')
          .child(path)
          .child(idConsulta)
          .child('ArquivosApoio')
          .child(idArquivo)
          .remove();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> setAvaliarConsulta(String id, int estrelas) async {
    try {
      final TransactionResult transactionResult = await db
          .child('consultas/concluidas/$id')
          .runTransaction((Object? mutableData) {
        if (mutableData != null) {
          Map<String, dynamic> _mutableData =
              Map<String, dynamic>.from(mutableData as Map);
          if (_mutableData['Estrelas'] == null) {
            _mutableData['Estrelas'] = estrelas;
          }
          return Transaction.success(_mutableData);
        } else {
          return Transaction.abort();
        }
      });

      if (transactionResult.committed) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }
}
