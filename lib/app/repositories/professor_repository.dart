import 'package:app_pde/app/models/consulta.dart';
import 'package:app_pde/app/models/dtos/consulta_dto.dart';
import 'package:app_pde/app/models/dtos/pedido_saque_professor_dto.dart';
import 'package:app_pde/app/models/pedido_saque_professor.dart';
import 'package:app_pde/app/repositories/firebase_repository.dart';
import 'package:app_pde/app/shared/controllers/auth_controller.dart';
import 'package:app_pde/app/shared/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfessorRepository extends FirebaseRepository {
  // ignore: unused_field
  final FirebaseDatabase _db;
  final FirebaseAuth _firebaseAuth;
  final AuthController _authController;

  ProfessorRepository(FirebaseDatabase db, FirebaseAuth firebaseAuth,
      AuthController authController)
      : _db = db,
        _firebaseAuth = firebaseAuth,
        _authController = authController,
        super(db, firebaseAuth);

  Future<List<Consulta>> getConsultasDisponiveis() => _getConsultas(
      path: 'ativas',
      consultasDisponiveisProfessor: true,
      situacao: SituacaoConsulta.disponiveis);

  Future<List<Consulta>> getConsultasDoProfessor() =>
      _getConsultas(path: 'ativas', situacao: SituacaoConsulta.agendadas);

  Future<List<Consulta>> getConsultasConcluidasProfessor() =>
      _getConsultas(path: 'concluidas', situacao: SituacaoConsulta.finalizada);

  Future<List<Consulta>> getConsultasOrcadasProfessor() => _getConsultas(
      path: 'ativas', isOrcada: true, situacao: SituacaoConsulta.orcadas);

  Future<List<Consulta>> _getConsultas({
    required String path,
    bool consultasDisponiveisProfessor = false,
    required SituacaoConsulta situacao,
    bool isOrcada = false,
  }) async {
    try {
      final userId =
          consultasDisponiveisProfessor ? null : _firebaseAuth.currentUser!.uid;

      final dbEvent = await db
          .child('consultas')
          .child(path)
          .orderByChild('IDProfessor')
          .equalTo(userId)
          .once();

      if (dbEvent.snapshot.value == null) return [];
      final json = Map<String, dynamic>.from(dbEvent.snapshot.value as Map);
      final toReturn =
          json.entries.where((element) => element.value['IDMateria'] != null);
      return toReturn.map((e) {
        final consultaDTO = ConsultaDTO.fromJson(e.value)
            .copyWith(id: e.key, situacao: situacao);
        return consultaDTO.toDomain();
      }).toList();
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }

  Future<bool> setProfessorConsulta(String id) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final TransactionResult transactionResult =
          await db.child('consultas/ativas/$id').runTransaction((mutableData) {
        if (mutableData != null) {
          Map<String, dynamic> _mutableData =
              Map<String, dynamic>.from(mutableData as Map);
          if (_mutableData['IDProfessor'] == null) {
            _mutableData['IDProfessor'] = userId;
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

  Future<bool> setBanirProfessor(String id) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final TransactionResult transactionResult =
          await db.child('consultas/ativas/$id').runTransaction((mutableData) {
        if (mutableData != null) {
          Map<String, dynamic> _mutableData =
              Map<String, dynamic>.from(mutableData as Map);
          final Map<dynamic, dynamic> json = Map<dynamic, dynamic>();
          if (_mutableData['ProfessoresBanidos'] == null) {
            json.addAll(mutableData['ProfessoresBanidos']);
          }
          json['$userId'] = true;
          mutableData['ProfessoresBanidos'] = json;
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

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final user = _authController.user!;
      if (user.idPermissao == 1) {
        final user = await db.child('users').child('professores').child(userId);
        await user.update({'token': token});
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> requestProfessorWithdraw(PedidoSaqueProfessor pedido) {
    final pedidoDTO = PedidoSaqueProfessorDTO.fromDomain(pedido);
    try {
      return db
          .child('pedidosSaquesProf')
          .child(pedido.idProfessor)
          .set(pedidoDTO.toJson());
    } catch (e) {
      print(e);
      throw Failure(e.toString());
    }
  }
}
