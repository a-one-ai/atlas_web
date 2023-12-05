import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/res_model.dart';

String Mainurl = 'http://184.105.215.243:8000';
Future uploadStream(String text) async {
  //http://90fb-34-125-113-217.ngrok.io/summarize_video
  // var request = http.MultipartRequest('POST', Uri.parse('http://90fb-34-125-113-217.ngrok.io/summarize_video'));

  Uri url = Uri.parse('$Mainurl/getYoutubeVideoLink');
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
      // then throw an exception
      print('Failed to send text. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // If we run into an error, print it to the console
    print('Caught error: $e');
  }
}
