import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../../model/res_model.dart';
import '../api/api_helper.dart';


pickVideoFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false,
  );

  if (result != null) {
    PlatformFile file = result.files.first;

    var res=await uploadVideo(file);

    return res;
  } else {
    return null;
  }
}

pickAudioFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
    allowMultiple: false,
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    var res=await uploadAudio(file);
    return res;
  }
}


Future uploadAudio(
    PlatformFile selectedFile
    ) async {
  if (kDebugMode) {
    print('uploading audio on server');
  }
  var url = Uri.parse("$Mainurl/getAudioFile");
  var request = http.MultipartRequest("POST", url);
  var audioFile=http.MultipartFile.fromBytes('audio', selectedFile.bytes!,
      contentType: MediaType('multipart', 'form-data'), filename: selectedFile.name);
  request.files.add(audioFile);

  try {
    request.send().then((response) async {
      if (response.statusCode == 200) {

        var responseBody = await response.stream.bytesToString();
        if (kDebugMode) {
          print('Server response: $responseBody');
        }
        var res= SummaryResponse.fromJson(json.decode(responseBody));


        return res;

      } else {
        if (kDebugMode) {
          print('file upload failed');
        }
      }
    });
  } on Exception catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

uploadVideo(
    PlatformFile selectedFile
    ) async {
  var url = Uri.parse("$Mainurl/getVideoFile");
  var request = http.MultipartRequest("POST", url);
  var videoFile=http.MultipartFile.fromBytes('video', selectedFile.bytes!,
      contentType: MediaType('multipart', 'form-data'), filename: selectedFile.name);
  request.files.add(videoFile);

  request.send().then((response) async {
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("File uploaded successfully");
      }
      var responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print('Server response: $responseBody');
      }
      var res= SummaryResponse.fromJson(json.decode(responseBody));


      return res;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (kDebugMode) {
        print('file upload failed');
      }
    }
  });
}
