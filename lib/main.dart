import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/blocs/login_bloc/login_bloc.dart';
import 'package:liro/data/shared_preferences/shared_preferences.dart';
import 'package:liro/resources/constants/app_theme.dart';
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

    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: systemBrightness == Brightness.light
            ? Colors.transparent
            : Colors.transparent,
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
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => LocationBloc()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
