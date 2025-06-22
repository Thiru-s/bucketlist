import 'dart:ui';

import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// Colors Style
abstract class AppColoStyles {

  static const splashColor = Color(0xFF008C45);
  static const primaryColor = Color(0xff3C2F28);

   static const scaffoldBG = Color(0xffFFF8F0);


  static const secondaryColor = Color(0xFF555555);
  static const hintTextColor = Color(0xFF3c2f28);
  static const greyLine = Color(0xFFBDBDBD);
  static const textColor = Color(0xff3C2F28);
  static const textFagColor = Color(0xff404040);

  static Color bgAlbum = const Color(0xffB0E6CB);
  static Color bgAlbum2 = const Color(0xFF66BAB4);
  static Color txtColor = const Color(0xFF575655);

  static Color green = Colors.green;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color grey = Colors.grey.shade800;
  static Color bgAudio = Color(0XFFC2D6D6);

  static LinearGradient gradient() => const LinearGradient(
    begin: Alignment.topCenter, // Start at the top
    end: Alignment.bottomCenter, // End at the bottom
    colors: [

      Color(0xFFF7EF81), // #15B563
      Color(0xFF008C45), // #008C45
    ],
    stops: [0.3177, 0.9896], // 31.77% and 98.96%
  );

  static LinearGradient buttonGradient() => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF02A959), // #02A959
      Color(0xFF008E46), // #008E46
    ],
  );

  static LinearGradient appBarGradient() => const LinearGradient(
    begin: Alignment.centerLeft, // Start at the left
    end: Alignment.centerRight, // End at the right
    colors: [
      Color(0xFFF7EF81), // #15B563// Color(0xFFF7EF81),
      Color(0xFFF6C472), // #008C45// Color(0xFFFEC062),
    ],
    stops: [0.3177, 0.9896], // 31.77% and 98.96%
  );


}

// Text Style


abstract class AppTextStyle {
  static TextStyle titleStyle = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Poppins",
      color: AppColoStyles.primaryColor);

  static TextStyle normalBoldTextStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
      color: AppColoStyles.black);

  static TextStyle normalTextStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins",
      color: AppColoStyles.black);

 static TextStyle hintTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins",
      color: AppColoStyles.black);


}

// Buttons Style

abstract class AppButtonStyle {
  static ButtonStyle socialSingInBtnStyle = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(14.sp)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
        side: const BorderSide(color: Colors.white),
      ),
    ),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );
}