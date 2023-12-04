import 'package:flutter/material.dart';

import '../../../core/colors/colors_manager.dart';



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
             child: Image.asset('assets/image/ill1.png', color: Colors.deepPurple,
             fit: BoxFit.cover,

             ),
           ),
         SafeArea(child: child)
        ],
      ),
    );
  }
}
