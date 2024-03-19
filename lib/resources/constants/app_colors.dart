import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue = 0xFF00FF97; // Updated with the new primary color

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE0FFF2),
      100: Color(0xFFB3FFDE),
      200: Color(0xFF80FFC7),
      300: Color(0xFF4DFFB1),
      400: Color(0xFF26FF9F),
      500: Color(_primaryValue),
      600: Color(0xFF00CC7A),
      700: Color(0xFF00B86B),
      800: Color(0xFF009E5A),
      900: Color(0xFF007A41),
    },
  );

  static const Color alertColor = Color(0xFFE01B1B);
  static const Color secondaryColor = Color(0xFF0E403D);
  static const Color yellowColor = Color(0xFFDBFF00);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xff000000);
  static const Color greyColor = Color(0xFFF2F6FF);

}
