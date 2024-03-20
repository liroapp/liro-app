import 'package:flutter/material.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> getLocationPermission(BuildContext context) async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      // Permission granted, do nothing
    } else if (permissionStatus.isDenied) {
      // Permission denied, show snackbar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.blackColor,
          content: const Text(
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