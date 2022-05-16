import 'package:equatable/equatable.dart';

class Problema extends Equatable {
  final String id;
  final DateTime data;
  final bool resolvido;

  const Problema({
    required this.id,
    required this.data,
    required this.resolvido,
  });

  @override
  List<Object?> get props => [data, id, resolvido];
}
