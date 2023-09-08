import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImagetoStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required Uint8List file, required String email}) async {
    String resp = 'Some error occured';
    try {
      String imagepath = "profileof$email";
      String imageUrl = await uploadImagetoStorage(imagepath, file);

      await _firestore
          .collection('userprofile')
          .add({'imageurl': imageUrl, 'email': email});
      resp = 'success';
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
