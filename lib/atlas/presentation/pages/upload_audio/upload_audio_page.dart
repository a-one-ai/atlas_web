
import 'package:atlas_web_final/atlas/presentation/services/file_helper/pick_file.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/colors/colors_manager.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../result/result_page.dart';

class UploadAudioPage extends StatefulWidget {

  UploadAudioPage({
    Key? key,

  }) : super(key: key);

  Color FirstColor =AudioUploadPattern.firstColor;
  Color SecondColor =AudioUploadPattern.secondColor;
  Color ThirdColor =AudioUploadPattern.thirdColor;
  Color FourthColor   =AudioUploadPattern.fourColor;



  @override
  State<UploadAudioPage> createState() => _UploadAudioPageState();
}

class _UploadAudioPageState extends State<UploadAudioPage> {
  bool is_loading = false;
  bool is_uploaded = false;
  bool is_uploading=false;

  List<int>? _selectedFile;

  Uint8List? _bytesData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.accept = 'audio/*';
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

          title: TopMenu(size: size,iconColor: widget.FirstColor,),
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
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: widget.FirstColor),
                ),
                SizedBox(height: 20),
                Text(
                  'Transcribe your audio with ease!',
                  style: TextStyle(fontSize: 20, color: widget.SecondColor),
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
                        color: widget.SecondColor,
                      ),
                      child: Center(child:
                      LoadingAnimationWidget.staggeredDotsWave(
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
                        color: widget.ThirdColor,
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
                          color: widget.ThirdColor,
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
                      startWebFilePicker();
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
                      // if (_selectedFile == null) {
                      //   print('No file selected');
                      //   setState(() {
                      //     is_loading = false;
                      //   });
                      //   return;
                      // }

                     await uploadAudio(_selectedFile).then((response) async {
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

                                    color: widget.FirstColor,
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
                      backgroundColor:

                      widget.FirstColor,


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
              ],
            ),
          ),
        ),
      ),
    );

  }
}
