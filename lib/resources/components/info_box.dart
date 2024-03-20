import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_fonts.dart';
import 'package:liro/resources/constants/app_spacings.dart';

// ignore: must_be_immutable
class InfoBox extends StatelessWidget {
  String info;
  String icon;
  InfoBox({super.key, required this.info, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          AppSpaces.horizontalspace5,
          SvgPicture.asset(
            icon,
            height: 50,
            width: 50,
            // fit: BxFit.cover,
          ),
          AppSpaces.horizontalspace20,
          Expanded(
            child: Text(
              info,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.secondaryColorText16,
            ),
          ),
          AppSpaces.horizontalspace20,
        ],
      ),
    );
  }
}
