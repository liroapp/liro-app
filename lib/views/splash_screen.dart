import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoDasboard(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.secondaryColor,
        statusBarIconBrightness: Brightness.light));
    return const Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                AppAssets.splashScreenLogo,
              ),
              fit: BoxFit.cover,
              height: 50,
            ),
          )
        ],
      ),
    );
  }

  gotoDasboard(BuildContext ctx) async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
