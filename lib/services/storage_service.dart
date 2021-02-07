import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage mainStorage = FirebaseStorage.instance;
  Future<String> uploadImage({String userId, String imagePath}) async {
    var imageName = imagePath.split('/').last;
    var cloudImage = await mainStorage.ref('$userId/$imageName').putFile(File(imagePath));
    return await cloudImage.ref.getDownloadURL();
  }
}
