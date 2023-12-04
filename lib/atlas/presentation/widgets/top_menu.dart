import 'package:flutter/material.dart';

import '../../../core/colors/colors_manager.dart';



class TopMenu extends StatelessWidget {
   TopMenu({
    Key? key,
    required this.size,
    this.iconColor= Colors.deepPurple
  }) : super(key: key);

  final Size size;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.05,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:size.height*0.05),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    children: [
                      Image.asset('assets/icons/finnace.png',color: iconColor,),
                      const SizedBox(width: 10),
                      Text(
                        'ATLAS',
                        style: TextStyle(
                            color: kTitleColor,
                            fontSize: size.width * 0.02,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Image.asset('assets/icons/menu.png'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
