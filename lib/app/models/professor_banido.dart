import 'package:equatable/equatable.dart';

class ProfessorBanido extends Equatable {
  final String id;
  final bool banido;

  ProfessorBanido({required this.id, required this.banido});

  @override
  List<Object> get props => [id, banido];
}
