import 'package:firebase_storage/firebase_storage.dart';

import 'arquivo.dart';

class UploadCallback {
  final Arquivo file;
  final Stream<TaskSnapshot> progress;

  const UploadCallback({required this.file, required this.progress});
}
