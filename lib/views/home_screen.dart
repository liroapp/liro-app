import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/components/home_screen/info_area.dart';
import 'package:liro/resources/components/home_screen/location_search_area.dart';
import 'package:liro/resources/constants/app_colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, 
    required this.currentLocation,
   
  });
  LatLng currentLocation;
  LatLng? fromCoordinates;
  LatLng? toCoordinates;
  List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.darkPrimaryColor,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationSelectedState) {
                      polylineCoordinates = state.polylineCoordinates;
                      fromCoordinates = state.fromCoordinates;
                      toCoordinates = state.toCoordinates;
                    }

                    Set<Marker> markers = {};
                    if (fromCoordinates != null) {
                      markers.add(
                        Marker(
                          markerId: const MarkerId('From Location'),
                          position: fromCoordinates!,
                        ),
                      );
                    }
                    if (toCoordinates != null) {
                      markers.add(
                        Marker(
                          markerId: const MarkerId('To Location'),
                          position: toCoordinates!,
                        ),
                      );
                    }
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 10,
                      ),
                      markers: markers,
                      onMapCreated: (controller) async {
                        String darkTheme = '';
                        await DefaultAssetBundle.of(context)
                            .loadString(AppAssets.googleMapDarkTheme)
                            .then((value) {
                          darkTheme = value;
                        });
                        // ignore: deprecated_member_use
                        await controller.setMapStyle(darkTheme);
                        _controller.complete(controller);
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId('route'),
                          color: AppColors.primaryColor,
                          width: 2,
                          points: polylineCoordinates,
                        ),
                      },
                    );
                  },
                ),
                const LocationSearchArea(),
              ],
            ),
          ),
          const InfoArea(),
        ],
      ),
    );
  }
}
