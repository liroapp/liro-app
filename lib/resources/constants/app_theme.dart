import 'package:flutter/material.dart';
import 'package:liro/resources/constants/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor.shade100,
        circularTrackColor: AppColors.primaryColor,
      ),
      brightness: Brightness.dark,
      fontFamily: 'metropolis',
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      hintColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteColor,
      ),
      
    );
  }
}
