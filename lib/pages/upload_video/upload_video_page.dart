import 'package:atlas/pages/result_screen.dart';
import 'package:atlas/services/file_pick.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/background.dart';
import '../../components/constants.dart';
import '../../services/api.dart';


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

  bool is_loading = false;

  var file;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:

        Container(
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
                    GestureDetector(
                      onTap: () async {
                        // Logic to upload video/audio files
                        await pickVideoFile().then(( value){

                          setState(() {
                            is_uploaded = true;
                          });
                          if (value == null) {
                            if (kDebugMode) {
                              print('No file selected');
                            }

                            setState(() {
                              is_uploaded = false;
                            });
                            return;
                          }

                          ApiService().uploadStream(value).then((response) {
                            setState(() {
                              is_loading = true;
                            });
                            return Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>ResultScreen(
                                  results: {
                                     'ar_script': response.data!.arScript!,
                                    'en_script': response.data!.enScript!,
                                    'ar_summary': response.data!.arSummary!,
                                    'en_summary': response.data!.enSummary!,
                                    'transcript_with_time_stamp': response.data!.scriptTime!
                                  },

                                  color: AudioUploadPattern.secondColor,
                                )
                                )
                            );
                          }).catchError((e){
                            debugPrint(e);
                            setState(() {
                              is_loading = false;
                            });
                          });

                        }).catchError((e){
                          debugPrint(e.toString());
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

                      
                    
                    
                    SizedBox(height: 60),
                    
                    SizedBox(height: 60),

                    SizedBox(height: 20),
                  ],
                ),
                Text(
                  '© 2023 Atlas Transcription',
                  style: TextStyle(color: Color(0xFF5B0888)),
                ),
              ],
            ),
          ),
        ),
      ),
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
