// import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color primaryColor = fromHex('#311B92');
  static Color darkRedColor = fromHex('#B31312');
  static Color indigoColor = fromHex('#833AB4');
  static Color darkOrangeColor = fromHex('#B46D3A');
  static Color mainBlue = fromHex('#317185');
  static Color indigoA100 = fromHex('#8982ff');
  static Color gray10001 = fromHex('#f6f6f6');
  static Color gray20001 = fromHex('#ececec');
  static Color gray20004 = fromHex('#e7e7e7');
  static Color gray20005 = fromHex('#f0efef');
  static Color black900 = fromHex('#000000');
  static Color gray500 = fromHex('#aaaaaa');
  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
