import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/constants/app_colors.dart';

class LoginHeroBar extends StatelessWidget {
  const LoginHeroBar({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
  });

  final double deviceHeight;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * .3,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppAssets.loginBg),
                  ),
                ),
                height: deviceHeight * .2,
              ),
            ],
          ),
          Positioned(
            top: deviceHeight * .2 - 50,
            left: deviceWidth * .5 - 50,
            child: Hero(
                tag: 'liroIcon', child: SvgPicture.asset(AppAssets.liroIcon)),
          ),
        ],
      ),
    );
  }
}
