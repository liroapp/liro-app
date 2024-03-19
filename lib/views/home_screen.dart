import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/components/custom_buttons.dart';
import 'package:liro/resources/components/input_fields.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';
import 'package:liro/views/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpaces.verticalspace20,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(isFromLocation: true),
                ));
              },
              child: BlocBuilder<LocationBloc, LocationState>(
                buildWhen: (previousState, state) {
                  // Rebuild only when the state is FromLocationSelectedState
                  return state is FromLocationSelectedState;
                },
                builder: (context, state) {
                  if (state is FromLocationSelectedState) {
                    return Text(state.fromLocation);
                  } else {
                    return Text('No From location selected');
                  }
                },
              ),
            ),
            AppSpaces.verticalspace20,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(isFromLocation: false),
                ));
              },
              child: BlocBuilder<LocationBloc, LocationState>(
                buildWhen: (previousState, state) {
                  // Rebuild only when the state is ToLocationSelectedState
                  return state is ToLocationSelectedState;
                },
                builder: (context, state) {
                  if (state is ToLocationSelectedState) {
                    return Text(state.toLocation);
                  } else {
                    return Text('No To location selected');
                  }
                },
              ),
            ),
            AppSpaces.verticalspace20,
            PrimaryButtonwithIcon(
              buttonText: 'Get Diirectioins',
              buttonFunction: () {
                context.read<LocationBloc>().add(LocationGetDirectionsEvent());
              },
              buttonIcon: Icons.directions,
            ),
            AppSpaces.verticalspace20,
            Expanded(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  LatLng? fromCoordinates;
                  LatLng? toCoordinates;

                  if (state is LocationSelectedState) {
                    fromCoordinates = state.fromCoordinates;
                    toCoordinates = state.toCoordinates;
                  }

                  // Initialize set for markers
                  Set<Marker> markers = {};

                  // Add markers if coordinates are available
                  if (fromCoordinates != null) {
                    markers.add(
                      Marker(
                        markerId: MarkerId('From Location'),
                        position: fromCoordinates,
                      ),
                    );
                  }
                  if (toCoordinates != null) {
                    markers.add(
                      Marker(
                        markerId: MarkerId('To Location'),
                        position: toCoordinates,
                      ),
                    );
                  }

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(11.315156, 75.997550),
                      zoom: 14,
                    ),
                    markers: markers, // Set the markers on the Google Map
                  );
                },
              ),
            ),
            Container(
              color: AppColors.primaryColor,
              height: MediaQuery.of(context).size.height * .1,
            ),
          ],
        ),
      ),
    );
  }
}
