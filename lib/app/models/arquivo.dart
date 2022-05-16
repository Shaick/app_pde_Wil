// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Arquivo extends Equatable {
  final String? id;
  final String nome;
  final String? downloadUrl;
  final String storagePath;
  String? devicePath;
  final int? size;
  final String? fileExtension;
  final DateTime timestamp;
  final String displayName;

  Arquivo(
      {this.id,
      required this.nome,
      this.downloadUrl,
      required this.storagePath,
      required this.timestamp,
      this.devicePath,
      this.size,
      this.fileExtension,
      required this.displayName});

  @override
  List<Object?> get props => [
        id,
        nome,
        displayName,
        downloadUrl,
        storagePath,
        timestamp,
        devicePath,
        size,
        fileExtension,
      ];
}
