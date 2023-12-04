



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/colors/colors_manager.dart';
import '../../services/api/api_helper.dart';
import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../result/result_page.dart';


class UploadLinkPage extends StatefulWidget {
  UploadLinkPage({
    Key? key,

  }) : super(key: key);



  @override
  State<UploadLinkPage> createState() => _UploadLinkPageState();
}


class _UploadLinkPageState extends State<UploadLinkPage> {

  late TextEditingController _streamLink;
  bool is_loading = false;
  bool url_valid=false;

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

    var size = MediaQuery.of(context).size;
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,

          title: TopMenu(size: size,iconColor: LinkUploudPattern.firstColor,),
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
                              color: LinkUploudPattern.secondColor
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
                        onFieldSubmitted: (value){
                          checkForUrl(value);
                        },
                        onChanged: (value){
                          checkForUrl(value);
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      // onPressed: (){
                      //   Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (context)=>ResultScreen(
                      //         results: {
                      //           'ar_script':' response.data!.arScript!',
                      //           'en_script': 'response.data!.enScript!',
                      //           'ar_summary': 'response.data!.arSummary!',
                      //           'en_summary': 'response.data!.enSummary!',
                      //           'transcript_with_time_stamp': 'response.data!.scriptTime!'
                      //         },
                      //
                      //         color: LinkUploudPattern.secondColor,
                      //       )
                      //       )
                      //   );
                      // },
                       onPressed:startTranscription,
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Start Transcription',
                          style: TextStyle(fontSize: 20, color: Color(0xFFFAF1E4)),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor:
                      url_valid?
                      LinkUploudPattern.secondColor:
                          LinkUploudPattern.fourColor
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


  Future<void> startTranscription() async {
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

   await uploadStream(_streamLink.text).then((value) async {
      if (kDebugMode) {
        print('value: $value');
      }
      await handleTranscriptionResponse(value);
    }).catchError((e) {
      handleError(e);
    }).whenComplete(() {
      setState(() {
        is_loading = false;
      });
    });
  }

  Future<void> handleTranscriptionResponse( response) async {
    if (response == null) {
      showSnackBar('Check your internet connection', isError: true);
      return;
    }

   await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ResultScreen(
        color: LinkUploudPattern.firstColor,
        results: {
          'ar_script': response.data!.arScript!,
          'en_script': response.data!.enScript!,
          'ar_summary': response.data!.arSummary!,
          'en_summary': response.data!.enSummary!,
          'transcript_with_time_stamp': response.data!.scriptTime!
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

    setState(() {
      url_valid=text.contains('youtube') || text.contains('youtu.be');
    });

    return url_valid;
  }

  SnackBar showSnackBar(String s, {required bool isError}) {
    return SnackBar(
      content: Text(s),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }
}
