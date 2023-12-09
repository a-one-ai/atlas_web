

// ignore: must_be_immutable
import 'package:flutter/material.dart';


import '../../../core/colors/colors_manager.dart';
import '../../widgets/top_menu.dart';
import '../home_page/home_page.dart';

class LandingPage extends StatelessWidget {
  String subtitle =
      'features 98.5% accuracy in video transcriptions and translations. With over 125 languages supported, effortlessly transcribe your videos to text for better documentation of your video conferences, interviews, lectures, and presentations. You can also automatically add subtitles to reach a wider audience. Save time, improve accessibility, and enhance the searchability of your content with ATLAS artificial intelligence software.';

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,

            title: TopMenu(size: size,),
        toolbarHeight: 100,
        ),

        backgroundColor: kbBackgroundColor,
        body: Column(
          children: [

            size.width > 600?
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        if (size.width > 600)
                          Image.network(
                           "https://firebasestorage.googleapis.com/v0/b/todo-33828.appspot.com/o/ill1.png?alt=media&token=6d6fc581-1c61-4f8f-874f-33f26e5c60b0",
                            color: Colors.deepPurple,
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                'ATLAS TRANSCRIPTION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.03,

                                  color: kTitleColor,
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,

                                  color: kTextColor,
                                ),
                              ),
                              SizedBox(height: size.height * 0.08),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) =>const HomeScreen()
                                      ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[900],
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: size.width * 0.04),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                    ),
                                    child: const Text(
                                      'Get Started',
                                      style: TextStyle(
                                        // fontSize: size.width * 0.01,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/todo-33828.appspot.com/o/hero-img.png?alt=media&token=812fb793-ed05-4797-a495-3e1362a2c14d',
                      fit: BoxFit.cover,
                    ),
                    // child: Container(
                    //   decoration:  BoxDecoration(
                    //     color: Color(0xffF5F5F5),
                    //     image: DecorationImage(
                    //       image: NetworkImage(
                    //         'https://images.unsplash.com/photo-1622837137197-4b7b2b5b5b0f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlkZW8lMjB0cmFuc2NyaXB0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  )
                ],
              ),
            ):
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    // child: Container(
                    //   decoration:  BoxDecoration(
                    //     color: Color(0xffF5F5F5),
                    //     image: DecorationImage(
                    //       image: AssetImage(
                    //         'assets/image/hero-img.png',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/todo-33828.appspot.com/o/hero-img.png?alt=media&token=812fb793-ed05-4797-a495-3e1362a2c14d',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        if (size.width > 600)
                          Image.network(
                           "https://firebasestorage.googleapis.com/v0/b/todo-33828.appspot.com/o/ill1.png?alt=media&token=6d6fc581-1c61-4f8f-874f-33f26e5c60b0",
                            color: Colors.deepPurple,
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Spacer(),
                              Text(
                                'ATLAS TRANSCRIPTION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.03,
                                  color: kTitleColor,
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.03,
                                  color: kTextColor,
                                ),
                              ),
                              SizedBox(height: size.height * 0.08),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) => const HomeScreen()
                                      ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[900],
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: size.width * 0.04),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                    ),
                                    child: Text(
                                      'Get Started',
                                      style: TextStyle(
                                        fontSize: size.width * 0.03,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                               const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
