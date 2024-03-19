import 'package:flutter/material.dart';
import 'package:liro/resources/constants/app_spacings.dart';

// ignore: must_be_immutable
class PrimaryButtonwithIcon extends StatelessWidget {
  IconData? buttonIcon;
  String buttonText;
  VoidCallback? buttonFunction;
  PrimaryButtonwithIcon({
    super.key,
    this.buttonIcon,
    required this.buttonText,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ElevatedButton(
          onPressed: buttonFunction,
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                buttonIcon,
                size: 18,
              ),
              AppSpaces.horizontalspace20,
              Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}