import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_services/fb_file_stroage.dart';

Future<String?> pickVideoFile() async {
  await FilePicker.platform
      .pickFiles(
    type: FileType.video,
    allowMultiple: false,
  )
      .then((result) async {
    print(result!.files.first.name);
    var file = result.files.first;
    await uploadFileToFirebaseStorage(file).then((value) {
      value==null ?debugPrint('link is null'):
      debugPrint('link : $value');
      return value;
    }).catchError((e) {
      debugPrint('upload FB error is ${e.toString()}');
    }).catchError((e) {
      debugPrint('Error Pick File is ${e.toString()}');
    });
  });
}

Future<String?> pickAudioFile() async {
  await FilePicker.platform
      .pickFiles(
    type: FileType.audio,
    allowMultiple: false,
  )
      .then((result) async {
    print(result!.files.first.name);
    var file = result.files.first;
    await uploadFileToFirebaseStorage(file).then((value) {
      value==null ?debugPrint('link is null'):
      debugPrint('link : $value');

      return value;
    }).catchError((e) {
      debugPrint('upload FB error is ${e.toString()}');
    }).catchError((e) {
      debugPrint('Error Pick File is ${e.toString()}');
    });
  });
}
