import 'dart:async';
import 'package:bloc/bloc.dart';
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
    on<LocationGetDirectionsEvent>(
      _locationGetDirections,
    );
  }

  FutureOr<void> _locationGetDirections(event, emit) async {
    final directions =
        await LocationRepo().getDirections(fromCoordinates, toCoordinates);
    print(directions);
  }

  LatLng fromCoordinates = LatLng(0.0, 0.0);
  LatLng toCoordinates = LatLng(0.0, 0.0);

  String fromLocation = '';
  String toLocation = '';

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
        emit(FromLocationSelectedState(
            fromLocation: fromLocation, fromCoordinates: fromCoordinates));
      }
    } catch (error) {
      print(error);
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
        emit(ToLocationSelectedState(
            toLocation: toLocation, toCoordinates: toCoordinates));
        emit(LocationSelectedState(
            fromLocation: fromLocation,
            fromCoordinates: fromCoordinates,
            toLocation: toLocation,
            toCoordinates: toCoordinates));
        print(toLocation);
        print(toCoordinates);
        print(fromLocation);
        print(fromCoordinates);
      }
    } catch (error) {
      print(error);
    }
  }
}
