import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liro/data/shared_preferences/shared_preferences.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.initStorage();
  runApp(const Liro());
}
class Liro extends StatelessWidget {
  const Liro({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Detect the current brightness mode
    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            systemBrightness == Brightness.light ? Colors.transparent : Colors.black,
        statusBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        statusBarBrightness: systemBrightness,
        systemNavigationBarColor:
            systemBrightness == Brightness.light ? Colors.white : Colors.black,
        systemNavigationBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
    return MultiBlocProvider(
      providers: const [
       
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        theme: ThemeData(
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: AppColors.primaryColor.shade100,
              circularTrackColor: AppColors.primaryColor,
            ),
            brightness: Brightness.light, // Use the dark theme
            fontFamily: 'metropolis', // Set your custom font here
            primaryColor: AppColors.primaryColor,
            primaryColorDark: AppColors.primaryColor,
            primaryColorLight: AppColors.primaryColor,
            hintColor: AppColors.primaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.whiteColor
            )
          ),
           debugShowCheckedModeBanner: false,
      ),
    );
  }
}