import 'package:flutter/material.dart';

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
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(fontSize: 16, color: Colors.black,

                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              IconButton(
                icon: Icon(Icons.file_download_outlined, color: Colors.black),
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
