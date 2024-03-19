import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:liro/resources/constants/app_colors.dart';


class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static String formatPrice(String priceString) {
 
  final price = double.tryParse(priceString);

  if (price != null) {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final formattedPrice = format.format(price);
    return formattedPrice.endsWith('.00')
        ? formattedPrice.substring(0, formattedPrice.length - 3)
        : formattedPrice;
  } else {
    return priceString;
  }
}


  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.CENTER,
    );
  }

  static String formatPhoneNumber(String phoneNumber) {
    final numericPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return numericPhoneNumber;
  }
}
