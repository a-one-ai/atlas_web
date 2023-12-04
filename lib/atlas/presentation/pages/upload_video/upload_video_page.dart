import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/colors/colors_manager.dart';

import '../../services/file_helper/pick_file.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../result/result_page.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadVideoPage extends StatefulWidget {

  UploadVideoPage({
    Key? key,

  }) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  Color FirstColor =VideoUploadPattern.firstColor;

  Color SecondColor =VideoUploadPattern.secondColor;

  Color ThirdColor =VideoUploadPattern.thirdColor;

  Color FourthColor  =VideoUploadPattern.fourColor;

  bool is_uploaded = false;
  bool is_uploading=false;

  bool is_loading = false;


  List<int>? _selectedFile;

  Uint8List? _bytesData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.accept = 'video/*';
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      setState(() {
        is_uploading=true;
      });

      reader.onLoadEnd.listen((event) {
        setState(() {

          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
          _selectedFile!=null ? is_uploaded = true:is_uploaded=false;
          is_uploaded==true ?is_uploading=false:null;

        });
      });
      reader.onError.listen((event) {
        setState(() {
          is_uploaded = false;
          is_uploading=false;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

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

            title: TopMenu(size: size,iconColor: FirstColor,),
            toolbarHeight: 100,
          ),
          backgroundColor: Colors.transparent,
        body:

        Builder(
          builder: (context) {
            return Container(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      'Atlas Transcription',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: FirstColor),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Transcribe your video with ease!',
                      style: TextStyle(fontSize: 20, color: SecondColor),
                    ),
                    is_loading?Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          width: 200,
                          height: 200,
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: SecondColor,
                          ),
                          child: Center(child:
                          LoadingAnimationWidget.prograssiveDots(
                            // color: widget.FirstColor,
                            color: Colors.white,
                            size: 150,
                          ),
                          ),),
                        SizedBox(height: 40),
                      ],

                    ):
                    Column(
                      children: [
                        SizedBox(height: 60),
                        is_uploaded?Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: ThirdColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.cloud_done,
                                  size: 70,
                                  color: Color(0xFFFFFFFF),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'File Uploaded Successfully',
                                  style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
                                ),
                              ],
                            ),
                          ),
                        ):
                            is_uploading?
                            Container(
                              width: 250,
                              height: 150,
                              decoration: BoxDecoration(
                                color: ThirdColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child:Text('Uploading .... '
                                  ,style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                              )
                            ):

                        GestureDetector(
                          onTap: () async {
                            // Logic to upload video/audio files
                            // await uploud_video(context);
                            startWebFilePicker();
                          },
                          child: Container(
                            width: 250,
                            height: 150,
                            decoration: BoxDecoration(
                              color: ThirdColor,
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
                                    style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        is_uploaded?
                        ElevatedButton(onPressed: () async {
                          // Logic to start transcription
                          setState(() {
                            is_loading = true;
                          });
                          if (_selectedFile == null) {
                            if (kDebugMode) {
                              print('No file selected');
                            }
                            setState(() {
                              is_loading = false;
                            });
                            return;
                          }
                          setState(() {
                            is_loading=true;
                          });
                        await  uploadVideo(_selectedFile).then((response) async {
                            if (response != null) {
                             await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResultScreen(
                                        results: {
                                          'ar_script': response.data!.arScript!,
                                          'en_script': response.data!.enScript!,
                                          'ar_summary': response.data!.arSummary!,
                                          'en_summary': response.data!.enSummary!,
                                          'transcript_with_time_stamp': response.data!.scriptTime!
                                        },

                                        color: FirstColor,
                                      ),
                                ),
                              );
                            }
                          }
                          ).catchError((e){
                            setState(() {
                              is_loading = false;
                            });
                          })
                              .whenComplete(() {
                            setState(() {
                              is_loading = false;
                            });
                          });

                        }, child: Text('Start Transcription',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                          backgroundColor: FirstColor,


                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),


                        ),
                        ):
                        Container(),


                        SizedBox(height: 80),
                        Text(
                          '© 2023 Atlas Transcription',
                          style: TextStyle(color: Color(0xFF5B0888)),
                        ),
                  ],
                ),
                ]
              ),
            ),
                  );
          }
        ),
    )
    );
  }

  // Future<void> uploud_video(BuildContext context) async {
  //    // Logic to upload video/audio files
  //   await pickVideoFile().then(( value){
  //
  //     setState(() {
  //       is_uploaded = true;
  //     });
  //     if (value == null) {
  //       if (kDebugMode) {
  //         print('No file selected');
  //       }
  //
  //       setState(() {
  //         is_uploaded = false;
  //       });
  //       return;
  //     }
  //
  //     ApiService().uploadStream(value).then((response) {
  //       setState(() {
  //         is_loading = true;
  //       });
  //       return Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context)=>ResultScreen(
  //             results: {
  //               'ar_script': response.data!.arScript!,
  //               'en_script': response.data!.enScript!,
  //               'ar_summary': response.data!.arSummary!,
  //               'en_summary': response.data!.enSummary!,
  //               'transcript_with_time_stamp': response.data!.scriptTime!
  //             },
  //
  //             color: AudioUploadPattern.secondColor,
  //           )
  //           )
  //       );
  //     }).catchError((e){
  //       debugPrint(e);
  //       setState(() {
  //         is_loading = false;
  //       });
  //     });
  //
  //   }).catchError((e){
  //     debugPrint(e.toString());
  //     setState(() {
  //       is_loading = false;
  //     });
  //   });
  // }

  void showSnackBar(String s, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
