import 'package:atlas_web/core/utils/responsive.dart';
import 'package:atlas_web/presentation/home_page/home_page.dart';
import 'package:atlas_web/presentation/widgets/background.dart';
import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';

class LandingPage extends StatelessWidget {
  static const String title = 'ATLAS TRANSCRIPTION';
  static const String buttonText = 'Get Started';

  static const String subtitle =
      'features 98.5% accuracy in video transcriptions and translations. With over 99 languages supported, effortlessly transcribe your videos to text for better documentation of your video conferences, interviews, lectures, and presentations. You can also automatically add subtitles to reach a wider audience. Save time, improve accessibility, and enhance the searchability of your content with ATLAS artificial intelligence software.';

  const LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BackgroundWidget(
      child: Scaffold(
        appBar: Responsive.isMobile(context)
            ? null
            : AppBar(
                leading: Container(),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const LogoWidget(),
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      // overflow: TextOverflow.visible,

                      color: MediaQuery.of(context).size.width > 900
                          ? Colors.grey[700]
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the desired screen
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[900],
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
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
              child: Image.asset(
                "assets/icon/hero-img.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LogoWidget(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/icon/hero-img.png",
              fit: BoxFit.fill,
              height: 300,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the desired screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[900],
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
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
    );
  }
}
