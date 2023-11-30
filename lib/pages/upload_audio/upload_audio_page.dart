import 'package:atlas/components/constants.dart';
import 'package:atlas/pages/result_screen.dart';
import 'package:atlas/services/api.dart';
import 'package:atlas/services/file_pick.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/background.dart';


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
  @override
  Widget build(BuildContext context) {

    return BackgroundWidget(
      child: Scaffold(
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
                    GestureDetector(
                      onTap: () async {
                        // Logic to upload video/audio files
                       await pickAudioFile().then(( value){

                          setState(() {
                            is_uploaded = true;
                          });
                          if (value == null) {
                            print('No file selected');

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

                SizedBox(height: 20),
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
