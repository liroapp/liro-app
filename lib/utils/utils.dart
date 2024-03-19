import 'package:fluttertoast/fluttertoast.dart';
import 'package:liro/resources/constants/app_colors.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.CENTER,
    );
  }
}
