import 'package:atlas_web/Atlas/presentation/home_page/home_page.dart';
import 'package:atlas_web/Atlas/presentation/widgets/background.dart';
import 'package:atlas_web/core/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/colors_manager.dart';
import '../../../core/network_image.dart';
import '../widgets/top_title.dart';

class LandingPage extends StatelessWidget {

  static const String title = 'ATLAS TRANSCRIPTION';
  static const String buttonText = 'Get Started';

  static const String subtitle =
      'features 98.5% accuracy in video transcriptions and translations. With over 99 languages supported, effortlessly transcribe your videos to text for better documentation of your video conferences, interviews, lectures, and presentations. You can also automatically add subtitles to reach a wider audience. Save time, improve accessibility, and enhance the searchability of your content with ATLAS artificial intelligence software.';

  LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BackgroundWidget(
      child: Scaffold(
        appBar: Responsive.isMobile(context)
            ? null
            :

        AppBar(
          leading: Container(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TopMenu(),
          toolbarHeight: 100,
        ),
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 700) {
              return _buildWideLayout(context);
            } else {
              return _buildNarrowLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return BackgroundWidget(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                          subtitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            // overflow: TextOverflow.visible,

                            color: MediaQuery.of(context).size.width>900 ? Colors.grey[700] : Colors.black,
                          ),
                        ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the desired screen
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[900],
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                heroImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Container(
      color: kbBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopMenu(),

            Container(

              padding: EdgeInsets.all(8.0),
              child: Image.network(
                heroImageUrl,
                fit: BoxFit.fill,
                height: 300,
                width: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the desired screen
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[900],
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}