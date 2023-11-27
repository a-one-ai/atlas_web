import 'package:atlas/components/constants.dart';
import 'package:atlas/pages/result_screen.dart';
import 'package:atlas/services/api.dart';
import 'package:atlas/services/file_pick.dart';
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
  var file;
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
                      onTap: () {
                        // Logic to upload video/audio files
                        pickAudioFile().then((value){
                          setState(() {
                            file = value;
                            is_uploaded = true;
                          });

                        }).catchError((e){
                          debugPrint(e);
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          is_loading = true;
                        });
                        ApiService().transcriptAudio(file).then((response) {
                          return Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ResultScreen(
                                results: {
                                  'ar_script': response.arScript,
                                  'en_script': response.enScript,
                                  'ar_summary': response.arSummary,
                                  'en_summary': response.enSummary,
                                  'transcript_with_time_stamp': response.scriptTime
                                },

                                color: AudioUploadPattern.secondColor,
                              )
                              )
                          );
                        }).catchError((e){
                          debugPrint(e);
                        });
                        // // Logic to transcribe the uploaded file
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ResultScreen(
                        //       color: widget.SecondColor,
                        //       results: {
                        //         'ar_transcribe': 'Arabic Transcription',
                        //         'en_transcribe': 'English Transcription',
                        //         'ar_summary': 'Arabic Summary',
                        //         'en_summary': 'English Summary',
                        //         'transcribe_with_time_stamp': 'Transcription with Timestamp',
                        //       },
                        //     ),
                        //   ),

                      //  );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Start Transcription',
                          style: TextStyle(fontSize: 20, color: Color(0xFFFAF1E4)),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: widget.FirstColor,
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
                // AnimatedOpacity(
                //   opacity: 1.0,
                //   duration: Duration(seconds: 1),
                //   curve: Curves.easeInOut,
                //   child: Container(
                //     padding: EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       color: Color(0xFFA7C5EB), // Link Color
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Text(
                //       'Summarized Text Display Area\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl et libero tempus tincidunt. Morbi vitae velit velit.',
                //       style: TextStyle(fontSize: 16, color: Color(0xFF6C7A89)),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 60),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     IconButton(
                //       onPressed: () {
                //         // Navigate to social media page
                //       },
                //       icon: Icon(Icons.music_note, color: Color(0xFF3ABE9D)), // Audio Color
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Navigate to social media page
                //       },
                //       icon: Icon(Icons.videocam, color: Color(0xFF5B0888)), // Video Color
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Navigate to social media page
                //       },
                //       icon: Icon(Icons.link, color: Color(0xFF713ABE)), // Link Color
                //     ),
                //   ],
                // ),
                SizedBox(height: 20),
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
}
