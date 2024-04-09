import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liro/blocs/login_bloc/login_bloc.dart';
import 'package:liro/repositories/login_repo.dart';
import 'package:liro/resources/components/custom_buttons.dart';
import 'package:liro/resources/components/input_fields.dart';
import 'package:liro/resources/components/login_hero_bar.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_media_queries.dart';
import 'package:liro/resources/constants/app_messages.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';
import 'package:liro/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = AppMediaQueries.getDeviceHeight(context);
    double deviceWidth = AppMediaQueries.getDeviceWidth(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.loginScreenHeroColor,
        statusBarIconBrightness: Brightness.light));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  LoginHeroBar(
                      deviceHeight: deviceHeight, deviceWidth: deviceWidth),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Log in to Liro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppSpaces.verticalspace40,
                  Padding(
                    padding: AppPaddings.horizontalpadding20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        AppSpaces.verticalspace10,
                        //Email Field
                        CustomInputField(
                          hintText: 'Enter your username',
                          fieldIcon: Icons.email_outlined,
                          controller: usernameController,
                          focusedborderColor: AppColors.primaryColor,
                        ),
                        AppSpaces.verticalspace20,
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        AppSpaces.verticalspace10,
                        //Password Field
                        CustomInputField(
                          hintText: 'Enter your password',
                          fieldIcon: Icons.password_outlined,
                          controller: passwordController,
                          focusedborderColor: AppColors.primaryColor,
                          obscure: true,
                        ),
                        AppSpaces.verticalspace20,
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              LoginRepo().getCurrentLocation().then((value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            currentLocation: value,
                                          )),
                                  (route) => false,
                                );
                              });
                              showCustomToast(
                                  context, state.message, AppColors.blackColor);
                            } else if (state is LoginFailureState) {
                              showCustomToast(
                                  context, state.message, Colors.red);
                            } else if (state is LoginErrorState) {
                              showCustomToast(
                                  context, state.message, Colors.red);
                            }
                          },
                          builder: (context, state) {
                            bool isLoading =
                                state is LoginLoadingState ? true : false;
                            String username = usernameController.text;
                            String password = passwordController.text;
                            return LoadingButton(
                              isLoading: isLoading,
                              buttonText: 'Login',
                              buttonFunction: () async {
                                print(username);
                                print(password);
                                context.read<LoginBloc>().add(LoginUserEvent(
                                    username: username, password: password));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
