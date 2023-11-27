import 'package:atlas/pages/upload_audio/upload_audio_page.dart';
import 'package:atlas/pages/upload_video/upload_video_page.dart';
import 'package:flutter/material.dart';

import '../components/background.dart';
import '../components/constants.dart';
import '../components/top_menu.dart';
import 'upload_link/link_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BackgroundWidget(
      child: Scaffold(

        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;

            return ListView(
              children: [
                TopMenu(size: size),

                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 40,
                      alignment: isWideScreen ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _buildFeature(
                          context,
                          ' Video',
                          Icons.slow_motion_video,
                          Colors.white,
                          Color(0xFF5B0888),
                            UploadVideoPage()
                        ),
                        _buildFeature(
                          context,
                          'Link',
                          Icons.stream,
                          Colors.white,
                          Color(0xFFF10303),
                          LInkPage(),
                          // LiveStream(),
                        ),
                        _buildFeature(
                          context,
                          'Audio',
                          Icons.multitrack_audio,
                          Colors.white,
                          Color(0xFF3ABE9D),
                          UploadAudioPage()

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeature(
      BuildContext context,
      String title,
      IconData icon,
      Color textColor,
      Color bgColor,
      Widget route,

        ) {
    return InkWell(
      onTap: () {



        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        route

        ));
      },
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgColor.withOpacity(0.8), bgColor],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Icon(
                  icon,
                  size: 50,
                  color: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
