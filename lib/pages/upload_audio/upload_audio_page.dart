import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/colors/colors_manager.dart';
import '../../model/res_model.dart';
import '../../services/api/api_helper.dart';
import '../../services/file_helper/pick_file.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../result/result_page.dart';

class UploadAudioPage extends StatefulWidget {
  UploadAudioPage({
    Key? key,
  }) : super(key: key);

  Color FirstColor = AudioUploadPattern.firstColor;
  Color SecondColor = AudioUploadPattern.secondColor;
  Color ThirdColor = AudioUploadPattern.thirdColor;
  Color FourthColor = AudioUploadPattern.fourColor;

  @override
  State<UploadAudioPage> createState() => _UploadAudioPageState();
}

class _UploadAudioPageState extends State<UploadAudioPage> {
  bool is_loading = false;

  var response;

  @override
  Widget build(BuildContext context) {
    Future uploadAudio(PlatformFile selectedFile) async {
      if (kDebugMode) {
        print('uploading audio on server');
      }
      var url = Uri.parse(Mainurl + "/getAudioFile");
      var request = http.MultipartRequest("POST", url);
      var audioFile = await http.MultipartFile.fromBytes(
          'audio', selectedFile.bytes!,
          contentType: MediaType('multipart', 'form-data'),
          filename: selectedFile.name);
      request.files.add(audioFile);

      try {
        request.send().then((response) async {
          if (response.statusCode == 200) {
            var responseBody = await response.stream.bytesToString();
            if (kDebugMode) {
              print('Server response: $responseBody');
            }
            var res = SummaryResponse.fromJson(json.decode(responseBody));

            return res;
          } else {
            if (kDebugMode) {
              print('file upload failed');
              setState(() {
                is_loading=false;
              });
            }
          }
        });
      } on Exception catch (e) {
        setState(() {
          is_loading=false;
        });
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }

    pickAudioFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file != null) {
          setState(() {
            is_loading = true;
          });
        }
        var res = await uploadAudio(file);
        return res;
      }
    }

    var size = MediaQuery.of(context).size;
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TopMenu(
            size: size,
            iconColor: widget.FirstColor,
          ),
          toolbarHeight: 100,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  'Atlas Transcription',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: widget.FirstColor),
                ),
                SizedBox(height: 20),
                Text(
                  'Transcribe your audio with ease!',
                  style: TextStyle(fontSize: 20, color: widget.SecondColor),
                ),
                is_loading
                    ? Column(
                        children: [
                          SizedBox(height: 60),
                          Container(
                            width: 200,
                            height: 200,
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: widget.SecondColor,
                            ),
                            child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                // color: widget.FirstColor,
                                color: Colors.white,
                                size: 150,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 60),
                          ElevatedButton(
                            onPressed: () async {
                              // Logic to upload video/audio files
                              try {
                                var value = await pickAudioFile().then((value) {
                                  if (value != null) {
                                    setState(() {
                                      response = value;
                                      is_loading = false;
                                    });

                                    if (kDebugMode) {
                                      print(response);
                                    }

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ResultScreen(
                                            results: {
                                              'ar_script':
                                              value.data!.arScript!,
                                              'en_script':
                                              value.data!.enScript!,
                                              'ar_summary':
                                              value.data!.arSummary!,
                                              'en_summary':
                                              value.data!.enSummary!,
                                              'transcript_with_time_stamp':
                                                  value.data!.scriptTime!,
                                            },
                                            color:
                                                AudioUploadPattern.firstColor,
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      is_loading = true;
                                    });
                                  }
                                });
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Error: $e');
                                }
                              }
                              // } finally {
                              //   setState(() {
                              //     is_loading = false;
                              //   });
                              // }
                            },
                            child: Container(
                              width: 250,
                              height: 150,
                              decoration: BoxDecoration(
                                color: widget.ThirdColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 70,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Drag & Drop or Click to Upload',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 120),
                          Text(
                            '© 2023 Atlas Transcription',
                            style: TextStyle(color: Color(0xFF5B0888)),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
