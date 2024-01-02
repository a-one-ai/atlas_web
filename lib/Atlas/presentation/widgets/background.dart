import 'package:atlas_web/core/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/colors_manager.dart';
import '../../../core/network_image.dart';




class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var MobileBackground = "https://img.freepik.com/free-photo/gray-abstract-wireframe-technology-background_53876-101941.jpg?w=740&t=st=1703946666~exp=1703947266~hmac=95ce22c062b107b934d1310bfb241362ae797276a29df3ee1b6305a41dd408ed";
    var size = MediaQuery.of(context).size;
    return Container(
height: size.height,
width: size.width,
      color: kbBackgroundColor,
      child: Stack(
        children: [
         !Responsive.isMobile(context)?
           Positioned(
             bottom: 0,
             child: Image.network(illustrationImageUrl, color: Colors.deepPurple,
             fit: BoxFit.cover,
             ),
           ):
            Image.network(MobileBackground, color: Colors.deepPurple,
              fit: BoxFit.cover,
            ),
         SafeArea(child: child)
        ],
      ),
    );
  }
}
