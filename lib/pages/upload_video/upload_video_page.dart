import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/colors/colors_manager.dart';

import '../../model/res_model.dart';
import '../../services/api/api_helper.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../result/result_page.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  Color FirstColor = VideoUploadPattern.firstColor;

  Color SecondColor = VideoUploadPattern.secondColor;

  Color ThirdColor = VideoUploadPattern.thirdColor;

  Color FourthColor = VideoUploadPattern.fourColor;

  bool is_loading = false;

  Future<SummaryResponse?> uploadVideo(PlatformFile selectedFile) async {
    var url = Uri.parse("$mainUrl/getVideoFile");
    var request = http.MultipartRequest("POST", url);
    var videoFile = http.MultipartFile.fromBytes(
        'video', selectedFile.bytes!,
        contentType: MediaType('multipart', 'form-data'),
        filename: selectedFile.name);
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
        SummaryResponse summaryResponse =
            SummaryResponse.fromJson(json.decode(responseBody));

        setState(() {
          is_loading = false;
        });
        _navigateToResult(summaryResponse);
      } else {
        if (kDebugMode) {
          print(response.statusCode);

          setState(() {
            is_loading = false;
          });
        }
        if (kDebugMode) {
          print('file upload failed');
        }
      }
    });
    return null;
  }

  _navigateToResult(SummaryResponse response) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            results: {
              'ar_script': response.data?.arScript ?? '',
              'en_script': response.data?.enScript ?? '',
              'ar_summary': response.data?.arSummary ?? '',
              'en_summary': response.data?.enSummary ?? '',
            
            },
            color: FirstColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
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
              iconColor: FirstColor,
            ),
            toolbarHeight: 100,
          ),
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Text(
                      'Atlas Transcription',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: FirstColor),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Transcribe your video with ease!',
                      style: TextStyle(fontSize: 20, color: SecondColor),
                    ),
                    is_loading
                        ? Column(
                            children: [
                              const SizedBox(height: 60),
                              Container(
                                width: 200,
                                height: 200,
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: SecondColor,
                                ),
                                child: Center(
                                  child: LoadingAnimationWidget.prograssiveDots(
                                    // color: widget.FirstColor,
                                    color: Colors.white,
                                    size: 150,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 60),
                              GestureDetector(
                                onTap: () async {
                                  // Logic to upload video/audio files
                                  // await uploud_video(context);

                                  FilePicker.platform
                                      .pickFiles(
                                    type: FileType.video,
                                    allowMultiple: false,
                                  )
                                      .then((result) async {
                                    if (result != null) {
                                      PlatformFile file = result.files.first;
                                      setState(() {
                                        is_loading = true;
                                      });
                                      await uploadVideo(file).catchError((e) {
                                        setState(() {
                                          is_loading = false;
                                        });
                                      });
                                    }
                                  }).catchError((e) {
                                    setState(() {
                                      is_loading = false;
                                    });
                                  });
                                },
                                child: Container(
                                  width: 250,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: ThirdColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child:  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    SvgPicture.asset(
                                          'assets/icons/cloud_upload_white_24dp.svg',
                                          width: 70,
                                          height:70,

                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
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
                              const SizedBox(height: 120),
                              const Text(
                                '© 2023 Atlas Transcription',
                                style: TextStyle(color: Color(0xFF5B0888)),
                              ),
                            ],
                          ),
                  ]),
            ),
          )),
    );
  }

  void showSnackBar(String s, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
