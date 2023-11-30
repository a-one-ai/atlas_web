


import 'package:atlas/components/constants.dart';
import 'package:atlas/model/response_model.dart';
import 'package:atlas/pages/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/background.dart';
import '../../services/api.dart';

class LInkPage extends StatefulWidget {
  LInkPage({
    Key? key,

  }) : super(key: key);



  @override
  State<LInkPage> createState() => _LInkPageState();
}


class _LInkPageState extends State<LInkPage> {

  late TextEditingController _streamLink;
  bool is_loading = false;

  @override
  void initState() {
    super.initState();
    _streamLink = TextEditingController();
  }

  @override
  void dispose() {
    _streamLink.dispose();
    super.dispose();
  }



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
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: LinkUploudPattern.firstColor),
                ),
                SizedBox(height: 20),
                Text(
                  'Transcribe your audio/video with ease!',
                  style: TextStyle(fontSize: 20, color: LinkUploudPattern.secondColor),
                ),
                SizedBox(height: 60),
                is_loading ? LoadingAnimationWidget.dotsTriangle(
                  color:LinkUploudPattern.thirdColor,
                  size: 200,
                ) :
                Column(
                  children: [
                    Container(
                      width: 600,
                      child: TextFormField(
                        controller: _streamLink,
                        decoration: InputDecoration(
                          hintText: 'Enter a Video Link',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          // Enhance input field styling
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: LinkUploudPattern.fourColor, // Change focus color
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed:is_loading ? null : startTranscription,
                      child:
                      is_loading ? LoadingAnimationWidget.prograssiveDots(
                        color: Colors.cyan,
                        size: 150,
                      ) :
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Start Transcription',
                          style: TextStyle(fontSize: 20, color: Color(0xFFFAF1E4)),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: LinkUploudPattern.fourColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),

                SizedBox(height: 20),
                Text(
                  '© 2023 Atlas Transcription',
                  style: TextStyle(color: LinkUploudPattern.thirdColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void startTranscription() {
    if (_streamLink.text.isEmpty) {
      showSnackBar('Please Enter Valid Stream Link', isError: true);
      return;
    }

    if (!checkForUrl(_streamLink.text)) {
      showSnackBar('Please Enter Valid Stream Link', isError: true);
      return;
    }

    setState(() {
      is_loading = true;
    });

    ApiService().uploadStream(_streamLink.text).then((value) {
      print('value: $value');
      handleTranscriptionResponse(value);
    }).catchError((e) {
      handleError(e);
    }).whenComplete(() {
      setState(() {
        is_loading = false;
      });
    });
  }

  void handleTranscriptionResponse(SummaryResponse value) {
    if (value == null) {
      showSnackBar('Check your internet connection', isError: true);
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ResultScreen(
        color: LinkUploudPattern.secondColor,
        results: {
          'ar_transcribe': value.data!.arScript ?? '',
          'en_transcribe': value.data!.enScript ?? '',
          'ar_summary': value.data!.arSummary ?? '',
          'en_summary': value.data!.enSummary ?? '',
          'transcribe_with_time_stamp': value.data!.scriptTime ?? '',
        },
      ),
    ));
  }

  void handleError(dynamic e) {
    setState(() {
      is_loading = false;
    });

    showSnackBar('Check your internet connection', isError: true);
  }

  bool checkForUrl(String text) {
    return text.contains('youtube') || text.contains('youtu.be');
  }

  SnackBar showSnackBar(String s, {required bool isError}) {
    return SnackBar(
      content: Text(s),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }
}

