import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/data/network/network_api_services.dart';
import 'package:liro/data/shared_preferences/shared_preferences.dart';
import 'package:liro/resources/app_urls/app_urls.dart';
import 'package:liro/utils/data_class.dart';
import 'package:liro/utils/permissions.dart';
import 'package:liro/views/home_screen.dart';
import 'package:liro/views/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginRepo {
  Future<DataClass> loginUser(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userLogin);

  void validateUser(context) async {
    final PermissionStatus permissionStatus =
        await getLocationPermission(context); // Ask for location permission
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
    // ignore: use_build_context_synchronously
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
}
