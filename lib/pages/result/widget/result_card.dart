import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/colors/colors_manager.dart';
import '../../../services/file_helper/save_file.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String content;
  final Color color;

  const ResultCard({
    Key? key,
    required this.title,
    required this.content,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: 400,
      decoration: BoxDecoration(
        color: kbBackgroundColor,
        border: Border.all(color: color, width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: const TextStyle(fontSize: 16, color: Colors.black,

                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/cloud_download_black_24dp.svg',

                ),
                onPressed: () {
                  // Logic to save file
                  var name = title.replaceAll(' ', '_').toLowerCase();
                  saveToFile(name, content);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
