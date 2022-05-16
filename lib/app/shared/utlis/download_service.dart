import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';

import 'device_utils.dart';

class DownloadFeedback {
  final String taskId;
  final DownloadTaskStatus status;
  final int progress;

  const DownloadFeedback(this.taskId, this.status, this.progress);
}

class DownloadService {
  static String get portName => 'download_port';

  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final sendPort = IsolateNameServer.lookupPortByName(portName);
    if (sendPort != null) {
      sendPort.send([id, status, progress]);
    }
  }

  final _receivePort = ReceivePort();
  Stream<DownloadFeedback> get downloadProgress => _receivePort
      .map((data) => DownloadFeedback(data[0], data[1], data[2]))
      .asBroadcastStream();

  DownloadService() {
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, portName);
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<String?> download({
    required String downloadUrl,
    required String fileName,
  }) async {
    Future<String?>? go;
    final path = await DeviceUtils().getDownloadFolderPath();
    if (path != null) {
      go = FlutterDownloader.enqueue(
        url: downloadUrl,
        savedDir: path,
        fileName: fileName,
        saveInPublicStorage: true,
      );
    }
    return go;
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping(portName);
    _receivePort.close();
  }
}
