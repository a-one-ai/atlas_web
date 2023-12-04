import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../model/res_model.dart';
import '../api/api_helper.dart';



Future uploadAudio(
    selectedFile
    ) async {
  if (kDebugMode) {
    print('uploading audio on server');
  }
  var url = Uri.parse(Mainurl+"/getAudioFile");
  var request = http.MultipartRequest("POST", url);
  request.files.add(http.MultipartFile.fromBytes('audio', selectedFile!,
      contentType: MediaType('multipart', 'form-data'), filename: selectedFile.name));

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
    selectedFile
    ) async {
  var url = Uri.parse(Mainurl+"/getVideoFile");
  var request = http.MultipartRequest("POST", url);
  request.files.add(http.MultipartFile.fromBytes('video', selectedFile!,
      contentType: MediaType('multipart', 'form-data'), filename: selectedFile.name));

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
