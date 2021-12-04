import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utilities.dart';

class Constants {
  // Constructor
  Constants.empty();

  /*
  SIZING
  */
  static const double padding = 20;
  static const double avatarRadius = 45;

  /*
  Duration
  */
  static const Duration veryFluidDuration = Duration(milliseconds: 200);
  static const Duration fluidDuration = Duration(milliseconds: 500);
  static const Duration normalDuration = Duration(seconds: 1);

  /*
  Curves
  */
  static Curve verySmoothCurve = Curves.easeOutCubic;

  /*
  THEME
  */
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    platform: TargetPlatform.iOS,
    fontFamily: 'Lato',
    appBarTheme: appBarTheme,
    inputDecorationTheme: inputDecorationTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: const IconThemeData(color: Colors.black),
    toolbarTextStyle: GoogleFonts.lato(color: Colors.black),
    titleTextStyle: GoogleFonts.lato(color: Colors.black),
  );

  static TextTheme textTheme = GoogleFonts.latoTextTheme();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );

  static BoxDecoration kAvatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(width: 4, color: Palette.ksmartPrimary),
  );

  /*
  DECORATIONS AND BORDERS
  */

  static const BoxDecoration kBoxDecoration = BoxDecoration(
    color: Colors.greenAccent,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const InputBorder blackInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: Palette.kTextColor),
    gapPadding: 10,
  );

  static RoundedRectangleBorder curvedRectBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );
}
