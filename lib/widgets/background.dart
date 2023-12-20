import 'package:flutter/material.dart';

import '../../core/colors/colors_manager.dart';



class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
height: size.height,
width: size.width,
      color: kbBackgroundColor,
      child: Stack(
        children: [
          // if (size.width > 600)
           Positioned(
             bottom: 0,
             child: Image.network('https://firebasestorage.googleapis.com/v0/b/todo-33828.appspot.com/o/ill1.png?alt=media&token=6d6fc581-1c61-4f8f-874f-33f26e5c60b0', color: Colors.deepPurple,
             fit: BoxFit.cover,

             ),
           ),
         SafeArea(child: child)
        ],
      ),
    );
  }
}
