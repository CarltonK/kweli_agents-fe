import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utilities.dart';

class Constants {
  // Constructor
  Constants.empty();

  /*
  REGEX
  */
  static RegExp emailValidatorRegExp =
      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  /*
  FORM ERRORS
  */
  /* DO NOT CHANGE */
  static const String kRequiredField = ' field is required';
  static const String kInvalidEmailError = 'Please enter a valid email';
  static const String kPassNullError = 'Please enter your password';
  static const String kShortPassError = 'Password is too short';
  static const String kMatchPassError = 'Passwords don\'t match';
  static const String kNamelNullError = 'Please enter your full name';
  static const String kPhoneNumberNullError = 'Please enter your phone number';

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

  /*
  APP-SPECIFIC 
  */
  static const List<String> wholesalerGoodsSold = [
    'FMCG goods',
    'Gas Outlet',
    'Wines and Spirits'
  ];

  static const List<String> wholesalerPaymentOptions = [
    'Mpesa till',
    'Mpesa paybill',
    'Equity till',
    'KCB till',
    'Cash',
    'Others'
  ];

  static const List<String> kioskGoodsSold = [
    'FMCG goods',
    'Food Kibandaski',
    'Gas Outlet',
    'Mama Mboga',
    'Wines and Spirits'
  ];

  static const List<String> kioskSupplierPaymentOptions = [
    'Cash',
    'Mpesa',
    'Bank Deposit'
  ];

  static const List<String> yesNoOptions = ['Yes', 'No'];

  static const List<String> genderOptions = ['Male', 'Female'];

  static const List<String> ownedRented = ['Owned', 'Rented'];

  static const List<String> businessDuration = [
    '1 - 2 months',
    '3 - 5 months',
    '6 - 8 months',
    '>12months'
  ];

  static const List<String> shopPaymentOptions = [
    'Mpesa till',
    'Mpesa paybill',
    'Equity till',
    'KCB till',
    'Cash',
    'Others'
  ];

  static const List<String> otherProducts = [
    'Airtime',
    'Kplc tokens',
    'Other bill payments',
    'Mpesa Withdrawal/deposit',
  ];

  static const String viabilityForWholesaler = 'Are you happy for your '
      'customers to buy their goods through you via an app? You get paid immediately but '
      'you have to confirm goods are available and prices, with payments received to'
      ' the your mpesa till number. We charge a commission for each sale made on the platform. '
      'We are helping kiosks maintain records to enable them access '
      'affordable credit from ourselves and banks/sacco\'s to buy goods from you';
}
