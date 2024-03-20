import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/repositories/location_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<SearchLocationEvent>(_searchLocation);
    on<LocationCoordinatesEvent>(_locationCoordinates);
    on<LocationGetDirectionsEvent>(_locationGetDirections);
  }

  LatLng fromCoordinates = const LatLng(0.0, 0.0);
  LatLng toCoordinates = const LatLng(0.0, 0.0);
  String fromLocation = '';
  String toLocation = '';
  String distance = '';
  String duration = '';

  Future<void> _searchLocation(
      SearchLocationEvent event, Emitter<LocationState> emit) async {
    try {
      final searchResults =
          await LocationRepo().getLocationSearchResults(event.searchTerm);

      if (searchResults.data['predictions'] != null) {
        emit(LocationSearchSuccessState(
            fromPredictions: searchResults.data['predictions']));
      } else {
        emit(LocationSearchErrorState(error: 'No predictions found.'));
      }
    } catch (error) {
      emit(LocationSearchErrorState(error: 'An error occurred: $error'));
    }
  }

  FutureOr<void> _locationCoordinates(
      LocationCoordinatesEvent event, Emitter<LocationState> emit) async {
    try {
      final coordinates =
          await LocationRepo().getLocationCoordinates(event.placeId);
      if (coordinates.data != null) {
        final location = coordinates.data['results'][0]['geometry']['location'];
        final LatLng placeCoordinates =
            LatLng(location['lat'], location['lng']);

        if (event.isFromCoordinates) {
          fromCoordinates = placeCoordinates;
          fromLocation = coordinates.data['results'][0]['formatted_address'];
        } else {
          toCoordinates = placeCoordinates;
          toLocation = coordinates.data['results'][0]['formatted_address'];
        }

        emit(LocationSelectedState(
            fromLocation: fromLocation,
            fromCoordinates: fromCoordinates,
            toLocation: toLocation,
            toCoordinates: toCoordinates));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> _locationGetDirections(
      LocationGetDirectionsEvent event, Emitter<LocationState> emit) async {
    final response = await LocationRepo().getDirections({
      'fromCoordinateslatitude': fromCoordinates.latitude,
      'fromCoordinateslongitude': fromCoordinates.longitude,
      'toCoordinateslatitude': toCoordinates.latitude,
      'toCoordinateslongitude': toCoordinates.longitude,
    });

    final List<LatLng> polylineCoordinates = [];
    final distanceText = response.data['distance']['text'];
    final durationText = response.data['duration']['text'];
    final List<dynamic> polyline = response.data['polyline'];

    for (var point in polyline) {
      polylineCoordinates.add(LatLng(point[0], point[1]));
    }

    emit(LocationSelectedState(
      fromLocation: fromLocation,
      fromCoordinates: fromCoordinates,
      toLocation: toLocation,
      toCoordinates: toCoordinates,
      polylineCoordinates: polylineCoordinates,
      distance: distanceText,
      duration: durationText,
    ));
  }

  
}
