// Future<void> _getLocationPermission(BuildContext context) async {
//     LocationPermission permissionStatus = await Geolocator.checkPermission();
//     if (permissionStatus == LocationPermission.whileInUse ||
//         permissionStatus == LocationPermission.always) {
//       Position position = await Geolocator.getCurrentPosition();
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => const ScreenOption(),
//       ));
//     } else if (permissionStatus == LocationPermission.denied) {
//       LocationPermission newPermissionStatus =
//           await Geolocator.requestPermission();
//       if (newPermissionStatus == LocationPermission.whileInUse ||
//           newPermissionStatus == LocationPermission.always) {
//         Position position = await Geolocator.getCurrentPosition();
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => const ScreenOption(),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Location permission is required.'),
//             action: SnackBarAction(
//               label: 'Open Settings',
//               onPressed: () {
//                 openAppSettings();
//               },
//             ),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Location permission is permanently denied.'),
//         ),
//       );
//     }
//   }