import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/repositories/location_repo.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<SearchLocationEvent>(_searchLocation);
    on<LocationFromCoordinatesEvent>(_getFromCoordinates);
    on<LocationToCoordinatesEvent>(_getToCoordinates);
    on<LocationCoordinatesEvent>(_locationCoordinates);

    on<LocationGetDirectionsEvent>(
      _locationGetDirections,
    );
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

  Future<void> _getFromCoordinates(
      LocationFromCoordinatesEvent event, Emitter<LocationState> emit) async {
    try {
      final coordinates =
          await LocationRepo().getLocationCoordinates(event.placeId);
      if (coordinates.data != null) {
        final location = coordinates.data['results'][0]['geometry']['location'];
        final LatLng placeCoordinates =
            LatLng(location['lat'], location['lng']);
        fromCoordinates = placeCoordinates;
        fromLocation = coordinates.data['results'][0]['formatted_address'];
        // emit(FromLocationSelectedState(
        //     fromLocation: fromLocation, fromCoordinates: fromCoordinates));
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

  Future<void> _getToCoordinates(
      LocationToCoordinatesEvent event, Emitter<LocationState> emit) async {
    try {
      final coordinates =
          await LocationRepo().getLocationCoordinates(event.placeId);
      if (coordinates.data != null) {
        final location = coordinates.data['results'][0]['geometry']['location'];
        final LatLng placeCoordinates =
            LatLng(location['lat'], location['lng']);
        toCoordinates = placeCoordinates;
        toLocation = coordinates.data['results'][0]['formatted_address'];
        // emit(ToLocationSelectedState(
        //     toLocation: toLocation, toCoordinates: toCoordinates));
        emit(LocationSelectedState(
            fromLocation: fromLocation,
            fromCoordinates: fromCoordinates,
            toLocation: toLocation,
            toCoordinates: toCoordinates));
        if (kDebugMode) {
          print(toLocation);
          print(toCoordinates);
          print(fromLocation);
          print(fromCoordinates);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  FutureOr<void> _locationGetDirections(event, emit) async {
    final directions =
        await LocationRepo().getDirections(fromCoordinates, toCoordinates);
    if (kDebugMode) {
      print(directions);
    }

    final List<LatLng> polylineCoordinates = [];
    final routes = directions.data['routes']; // Cast to appropriate type
    for (var route in routes) {
      final overviewPolyline = route['overview_polyline'];
      final points = overviewPolyline['points'];
      final List<PointLatLng> decodedPolyline =
          PolylinePoints().decodePolyline(points);
      // Convert PointLatLng to LatLng
      for (var point in decodedPolyline) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    if (routes.isNotEmpty) {
      final Map<String, dynamic> route =
          routes[0]; // Assuming only one route is returned
      final List<dynamic> legs = route['legs'];

      if (legs.isNotEmpty) {
        final Map<String, dynamic> leg =
            legs[0]; // Assuming only one leg is present

        // Extract distance and duration text
        distance = leg['distance']['text'];
        duration = leg['duration']['text'];
      }
      emit(LocationSelectedState(
          fromLocation: fromLocation,
          fromCoordinates: fromCoordinates,
          toLocation: toLocation,
          toCoordinates: toCoordinates,
          polylineCoordinates: polylineCoordinates,
          distance: distance,
          duration: duration
          ));
      // emit(LocationDirectionsLoadedState(
      //   polylineCoordinates: polylineCoordinates,
      //   fromCoordinates: fromCoordinates,
      //   toCoordinates: toCoordinates,
      // ));
    }
  }
}
