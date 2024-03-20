import 'package:flutter/material.dart';
import 'package:liro/resources/constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final IconData? fieldIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? bgColor;
  final Color? borderColor;
  final Color? focusedborderColor;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool editable;
  final bool autofocus;
  final bool obscure; // Added obscure property
  const CustomInputField({
    super.key,
    this.fieldIcon,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.keyboardType,
    this.validator,
    this.bgColor,
    this.borderColor,
    this.focusedborderColor,
    this.enabled = true,
    this.onChanged,
    this.editable = false,
    this.onTap,
    this.autofocus = false,
    this.obscure = false, // Added default value
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: bgColor ?? Colors.transparent,
          // border: Border.all(
          //   color: borderColor ?? Colors.grey,
          // ),
        ),
        child: TextFormField(
          obscureText: obscure, // Set obscureText based on the 'obscure' property
          autofocus: autofocus,
          onTap: () {
            if (onTap != null && editable) {
              onTap!();
            }
          },
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
          readOnly: editable,
          decoration: InputDecoration(
            prefixIcon: Icon(
              fieldIcon ?? Icons.abc,
              color: Colors.grey.shade500,
              size: 20,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: focusedborderColor ?? Colors.transparent,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
