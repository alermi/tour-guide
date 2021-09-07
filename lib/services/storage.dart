import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  static Future<Directory> getAppRootDir() {
    return getApplicationDocumentsDirectory();
  }

  static Future<void> downloadFile(String url) async {
    Directory appDocDir = await getAppRootDir();
    //TODO: Fix into directories
    File downloadToFile = File('${appDocDir.path}/' + url.split('/').last);
    if (!await downloadToFile.exists()) {
      downloadToFile.create(recursive: true);
    }
    try {
      Reference ref = FirebaseStorage.instance.ref(url);
      String downloadUrl = await ref.getDownloadURL();
      TaskSnapshot task = await ref.writeToFile(downloadToFile);
      return;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("Error caught on StorageService downloadFile.");
      print(e.message);
    }
  }
}
