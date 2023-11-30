import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../file_pick.dart';

Future<String?> uploadFileToFirebaseStorage(PlatformFile File) async {
  try {

var Data=File.bytes;
     String fileName = basename(File.name!);
     Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    var uploadTask = firebaseStorageRef.putData(Data!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;

  } catch (e) {
    if (kDebugMode) {
      print("Error uploading file: $e");
    }
    return null;


}



}
Future<void> deleteFileFromFirebaseStorage(String fileName) async {
  try {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    await firebaseStorageRef.delete();
    print('File $fileName deleted successfully.');
  } catch (e) {
    print('Error deleting file: $e');
  }
}
