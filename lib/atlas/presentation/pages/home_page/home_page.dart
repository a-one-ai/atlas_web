
import 'package:atlas_web_final/atlas/presentation/pages/home_page/widget/button_feature.dart';
import 'package:flutter/material.dart';

import '../../widgets/background.dart';
import '../../widgets/top_menu.dart';
import '../upload_audio/upload_audio_page.dart';
import '../upload_link/upload_link_page.dart';
import '../upload_video/upload_video_page.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BackgroundWidget(
      child: Scaffold(

        appBar: AppBar(
          leading: Container(),
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TopMenu(size: size,), // Assuming TopMenu is a custom widget for the title
        ),

        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;

            return ListView(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 40,
                      alignment: isWideScreen ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        FeatureWidget(
                          title: 'Video',
                          icon: Icons.slow_motion_video,
                          textColor: Colors.white,
                          bgColor: Color(0xFF833AB4),
                          route: UploadVideoPage(),
                        ),
                        FeatureWidget(
                          title: 'Link',
                          icon: Icons.stream,
                          textColor: Colors.white,
                          bgColor: Color(0xFFB31312),
                          route: UploadLinkPage(),
                        ),
                        FeatureWidget(
                          title: 'Audio',
                          icon: Icons.multitrack_audio_rounded,
                          textColor: Colors.white,
                          bgColor: Color(0xFFB46D3A),
                          route: UploadAudioPage(),

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


}
