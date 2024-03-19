import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/components/custom_buttons.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_fonts.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';
import 'package:liro/views/search_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  });

  LatLng? fromCoordinates;
  LatLng? toCoordinates;
  List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  target: LatLng(11.315156, 75.997550),
                  zoom: 12,
                ),
                markers: markers,
                onMapCreated: (controller) async {
                  String darkTheme = '';
                  await DefaultAssetBundle.of(context)
                      .loadString(AppAssets.googleMapDarkTheme)
                      .then((value) {
                    // print(value);
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
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  height: MediaQuery.of(context).size.height * .18,
                  decoration: BoxDecoration(
                      color: AppColors.darkPrimaryColor,
                      // border: Border.all(
                      //     color: AppColors.primaryColor.withOpacity(.5),
                      //     width: .3),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            // padding: AppPaddings.verticalpadding10,
                            // height: 50,
                            width: MediaQuery.of(context).size.width * .20 - 20,
                            // color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.originIcon,
                                  height: 24,
                                  width: 24,
                                  // fit: BoxFit.cover,
                                ),
                                SvgPicture.asset(
                                  AppAssets.dashIcon,
                                  height: 40,
                                  width: 30,
                                  // fit: BoxFit.cover,
                                ),
                                SvgPicture.asset(
                                  AppAssets.destinationIcon,
                                  height: 25,
                                  width: 25,
                                  // fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSpaces.horizontalspace10,
                      Row(
                        children: [
                          Container(
                            // padding: AppPaddings.verticalpadding5,
                            // height: 50,
                            width: MediaQuery.of(context).size.width * .80 - 10,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(isFromLocation: true),
                                    ));
                                  },
                                  child:
                                      BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                      if (state is LocationSelectedState &&
                                          state.fromLocation.isNotEmpty) {
                                        return Text(
                                          state.fromLocation,
                                          style: AppFonts.greyText16,
                                        );
                                      } else {
                                        return const Text(
                                          'Select from location',
                                          style: AppFonts.greyText12,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Divider(
                                  color: AppColors.whiteColor.withOpacity(.1),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              isFromLocation: false),
                                        ));
                                      },
                                      child: BlocBuilder<LocationBloc,
                                          LocationState>(
                                        builder: (context, state) {
                                          if (state is LocationSelectedState &&
                                              state.toLocation.isNotEmpty) {
                                            return Text(
                                              state.toLocation,
                                              style: AppFonts.greyText16,
                                            );
                                          } else {
                                            return const Text(
                                              'Select to location',
                                              style: AppFonts.greyText12,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<LocationBloc>()
                                            .add(LocationGetDirectionsEvent());
                                      },
                                      child: Icon(
                                        Icons.directions,
                                        size: 36,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 3,
                  height: 0,
                  indent: 0,
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .2 +
                20, // Adjust as needed
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // PrimaryButtonwithIcon(
                //   buttonText: 'Get Directions',
                //   buttonFunction: () {
                //     context
                //         .read<LocationBloc>()
                //         .add(LocationGetDirectionsEvent());
                //   },
                //   buttonIcon: Icons.directions,
                // ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: AppPaddings.fullpadding20,
              child: Container(
                padding: AppPaddings.horizontalpadding10,
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationSelectedState) {
                      return Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.carIcon,
                                height: 50,
                                width: 50,
                                // fit: BxFit.cover,
                              ),
                              AppSpaces.horizontalspace20,
                              Text(
                                state.distance ?? '',
                                style: AppFonts.secondaryColorText18,
                              ),
                              AppSpaces.horizontalspace20,
                              Text(
                                state.duration ?? '',
                                style: AppFonts.secondaryColorText18,
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                margin: EdgeInsets.only(right: 40),
                height: MediaQuery.of(context).size.height * .09,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
