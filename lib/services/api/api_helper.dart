import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/res_model.dart';

// String Mainurl = "http://184.105.208.147:8000";
//String Mainurl = 'https://dc9a74986c7a94985bbe502eb163b6f06.clg07azjl.paperspacegradient.com/';
//String Mainurl = 'https://atlas.thinkapp.org';
String Mainurl = 'https://us-central1-shsh-3fec7.cloudfunctions.net/serverrequests-api';
Future uploadStream(String text) async {

  Uri url = Uri.parse('$Mainurl/getYoutubeVideoLink');
  String requestBody = json.encode({"link": text});

  try {
    // Make a POST request
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: requestBody,
    );

    // Check the status code for the result
    if (response.statusCode == 200) {
      // This is a success

      final responseBody = json.decode(response.body);
      print('Server response: $responseBody');
      var res = SummaryResponse.fromJson(responseBody);

      return res;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception
      if (kDebugMode) {
        print('Failed to send text. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // If we run into an error, print it to the console
    if (kDebugMode) {
      print('Caught error: $e');
    }
  }
}
