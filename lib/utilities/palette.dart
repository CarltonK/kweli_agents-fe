import 'package:flutter/material.dart';

class Palette {
  static const Color backgroundWhite = Color(0XFFFFFFFF);

  static const Color backgroundGrey = Color(0XFFF5F6F9);

  static const Color ksmartPrimary = Color.fromRGBO(217, 118, 13, 1);
  static const Color ksmartRed = Color.fromRGBO(238, 141, 143, 1);
  static const Color ksmartGreen = Color.fromRGBO(90, 205, 123, 1);
  static const Color ksmartSecondary = Color.fromRGBO(41, 46, 64, 1);

  static const kTextColor = Color(0xFF757575);

  static const LinearGradient linearBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundWhite, backgroundWhite],
  );

  static const List<Color> paletteColors = [
    Colors.red,
    ksmartPrimary,
    Colors.green,
    Colors.yellow,
    Colors.pink,
  ];
}
