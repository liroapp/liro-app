import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/data/network/network_api_services.dart';
import 'package:liro/data/shared_preferences/shared_preferences.dart';
import 'package:liro/resources/app_urls/app_urls.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_fonts.dart';
import 'package:liro/utils/data_class.dart';
import 'package:liro/views/home_screen.dart';
import 'package:liro/views/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginRepo {
  Future<DataClass> loginUser(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userLogin);

  void validateUser(context) async {
    final PermissionStatus permissionStatus =
        await _getLocationPermission(context); // Ask for location permission
    if (permissionStatus == PermissionStatus.granted) {
      final accessToken = await SharedPref.instance.getAccessToken();
      if (accessToken != null) {
        await gotoHome(context);
      } else {
        await gotoLogin(context);
      }
    } else if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.permanentlyDenied) {
      // Do nothing here, permission denied or permanently denied
    }
  }

  gotoLogin(BuildContext ctx) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  gotoHome(BuildContext ctx) async {
    await Future.delayed(const Duration(seconds: 2));
    // Get current location after obtaining permission
    LatLng currentLocation = await getCurrentLocation();
    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(currentLocation: currentLocation),
    ));
  }

  Future<LatLng> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return const LatLng(11.315156, 75.997550);
    }
  }

  Future<PermissionStatus> _getLocationPermission(BuildContext context) async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      // Permission granted, do nothing
    } else if (permissionStatus.isDenied) {
      // Permission denied, show snackbar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.blackColor,
          content: Text(
            'Location permission is required.',
            style: AppFonts.primaryColorText12,
          ),
          action: SnackBarAction(
            label: 'Open Settings',
            
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied, show snackbar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.blackColor,
          content: Text(
            'Location permission is denied. Please Enable in settings',
            style: AppFonts.primaryColorText12,
          ),
        ),
      );
    }
    return permissionStatus;
  }
}
