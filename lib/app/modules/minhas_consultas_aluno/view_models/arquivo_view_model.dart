import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:app_pde/app/models/arquivo.dart';

class ArquivoViewModel {
  final String? id;
  final String? downloadUrl;
  final String displayName;
  final String fileName;
  final String? storagePath;
  final int? size;
  String? devicePath;
  final String? taskId;
  final int progress;
  final DownloadTaskStatus status;

  ArquivoViewModel({
    this.id,
    this.downloadUrl,
    required this.displayName,
    required this.fileName,
    this.storagePath,
    this.taskId,
    this.progress = 0,
    this.status = DownloadTaskStatus.undefined,
    this.size,
    this.devicePath,
  });

  bool get isImage => fileName.endsWith('jpg') || fileName.endsWith('png');

  bool get canDownload => downloadUrl?.isNotEmpty ?? false;

  String get fileExtension => fileName.split('.').last;

  bool canOpen() {
    if (devicePath == null) return false;
    return File(devicePath!).existsSync();
  }

  ArquivoViewModel copyWith({
    String? id,
    String? downloadUrl,
    String? displayName,
    String? fileName,
    String? storagePath,
    String? taskId,
    int? progress,
    DownloadTaskStatus? status,
    int? size,
    String? devicePath,
  }) {
    return ArquivoViewModel(
      id: id ?? this.id,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      displayName: displayName ?? this.displayName,
      fileName: fileName ?? this.fileName,
      storagePath: storagePath ?? this.storagePath,
      taskId: taskId ?? this.taskId,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      size: size ?? this.size,
      devicePath: devicePath ?? this.devicePath,
    );
  }

  factory ArquivoViewModel.withTask({
    required String id,
    required String downloadUrl,
    required String displayName,
    required String fileName,
    required DownloadTask task,
  }) {
    return ArquivoViewModel(
      id: id,
      downloadUrl: downloadUrl,
      displayName: displayName,
      fileName: fileName,
      taskId: task.taskId,
      progress: task.progress,
      status: task.status,
    );
  }

  Arquivo toDomain() {
    return Arquivo(
      id: id,
      downloadUrl: downloadUrl,
      nome: fileName,
      displayName: displayName,
      storagePath: storagePath ?? '',
      timestamp: DateTime.now(),
      devicePath: devicePath,
      fileExtension: fileExtension,
      size: size,
    );
  }

  PlatformFile toPlatformFile() {
    return PlatformFile(name: fileName, size: size ?? 0, path: devicePath);
  }

  factory ArquivoViewModel.fromPlatformFile(PlatformFile file) {
    return ArquivoViewModel(
      displayName: file.name,
      fileName: file.name,
      size: file.size,
      devicePath: file.path,
    );
  }

  @override
  String toString() => fileName;
}
