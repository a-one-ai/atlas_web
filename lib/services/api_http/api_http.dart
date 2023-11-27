
import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../model/response_model.dart';


class ApiService{
  String Mainurl='http://184.105.215.243:8000';
  Future uploadStream(String text) async {
    //http://90fb-34-125-113-217.ngrok.io/summarize_video
    // var request = http.MultipartRequest('POST', Uri.parse('http://90fb-34-125-113-217.ngrok.io/summarize_video'));

    Uri url = Uri.parse('${Mainurl}/getYoutubeVideoLink');
    try {
      // Make a POST request
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'link': text}),
      );

      // Check the status code for the result
      if (response.statusCode == 200) {
        // This is a success
        final responseBody = json.decode(response.body);
        print('Server response: $responseBody');
        var res=SummaryResponse.fromJson(responseBody);


        return res;
      } else {
        // If the server did not return a "200 OK response",
        // then throw an exception.
        print('Failed to send text. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // If we run into an error, print it to the console
      print('Caught error: $e');
    }
  }



  Future TranscriptVideo(PlatformFile tempFile) async {
//http://90fb-34-125-113-217.ngrok.io/summarize_video
    var request = http.MultipartRequest('POST', Uri.parse('${Mainurl}/getVideoFile'));

//    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:4000/summarize_video'));
    request.files.add(await http.MultipartFile.fromBytes('video', tempFile.bytes!));

    final streamedResponse = await request.send();
    final Response = await http.Response.fromStream(streamedResponse);
    final response = json.decode(Response.body);



    if (Response.statusCode == 200) {
      debugPrint('Uploaded!');
      debugPrint(response.toString());
      debugPrint(Response.body.toString());
      var res=SummaryResponse.fromJson(response);


      return res;
    } else {
      debugPrint(response.toString());
      debugPrint(Response.statusCode.toString());
      debugPrint('Failed to upload.');
      return response;
    }
  }

  Future TranscriptAudio(File tempFile) async {

    var request = http.MultipartRequest('POST', Uri.parse('${Mainurl}/getAudioFile'));
    request.files.add(await http.MultipartFile.fromPath('audio', tempFile.path));

    final streamedResponse = await request.send();
    final Response = await http.Response.fromStream(streamedResponse);
    final response = json.decode(Response.body);



    if (Response.statusCode == 200) {
      debugPrint('Uploaded!');
      debugPrint(response.toString());
      debugPrint(Response.body.toString());
      var res=SummaryResponse.fromJson(response);


      return res;
    } else {
      debugPrint(response.toString());
      debugPrint(Response.statusCode.toString());
      debugPrint('Failed to upload.');
      return response;
    }
  }

}