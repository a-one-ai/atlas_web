import 'package:flutter/material.dart';

import '../upload_audio/upload_audio_page.dart';
import '../upload_link/upload_link_page.dart';
import '../upload_video/upload_video_page.dart';
import '../widgets/background.dart';
import '../widgets/logo_widget.dart';
import 'widget/button_feature.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          title:
              const LogoWidget(), // Assuming TopMenu is a custom widget for the title
        ),
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;

            return ListView(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 40,
                      alignment: isWideScreen
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      children: const [
                        FeatureWidget(
                          title: 'Video',
                          icon:
                              "assets/icon/play_circle_outline_white_24dp.svg",
                          textColor: Colors.white,
                          bgColor: Color(0xFF833AB4),
                          route: UploadVideoPage(),
                        ),
                        FeatureWidget(
                          title: 'Link',
                          icon: "assets/icon/stream_white_24dp.svg",
                          textColor: Colors.white,
                          bgColor: Color(0xFFB31312),
                          route: UploadLinkPage(),
                        ),
                        FeatureWidget(
                          title: 'Audio',
                          icon: "assets/icon/graphic_eq_white_24dp.svg",
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
