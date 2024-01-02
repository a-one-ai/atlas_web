import 'package:atlas_web/core/network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/colors_manager.dart';



class TopMenu extends StatelessWidget {
  TopMenu({
    Key? key,
    this.iconColor= Colors.deepPurple
  }) : super(key: key);


  Color iconColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.05,

      ),
      alignment: Alignment.center,
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
                      Image.asset("assets/icon/logo_item.png",
                        height: 40,
                        width: 40,
                        color: iconColor,),
                      const SizedBox(width: 10),
                      Text(
                        'ATLAS',
                        style: TextStyle(
                            color: kTitleColor,

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
