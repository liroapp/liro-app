import 'package:flutter/material.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';

class PrimaryButtonwithIcon extends StatelessWidget {
  final IconData? buttonIcon;
  final String buttonText;
  final VoidCallback? buttonFunction;
  const PrimaryButtonwithIcon({
    super.key,
    this.buttonIcon,
    required this.buttonText,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalpadding10,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: ElevatedButton(
            onPressed: buttonFunction,
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
              padding: MaterialStatePropertyAll(
                AppPaddings.fullpadding14,
              ),
              elevation: MaterialStatePropertyAll(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  buttonIcon,
                  size: 18,
                  color: AppColors.secondaryColor,
                ),
                AppSpaces.horizontalspace20,
                Text(
                  buttonText,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
