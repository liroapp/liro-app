part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationSearchSuccessState extends LocationState {
  final List<dynamic> fromPredictions;
  LocationSearchSuccessState({required this.fromPredictions});
}

final class LocationSearchErrorState extends LocationState {
  final String error;
  LocationSearchErrorState({required this.error});
}

final class FromLocationSelectedState extends LocationState {
  final String fromLocation;
  final LatLng fromCoordinates;
  FromLocationSelectedState(
      {required this.fromLocation, required this.fromCoordinates});
}

final class ToLocationSelectedState extends LocationState {
  final String toLocation;
  final LatLng toCoordinates;
  ToLocationSelectedState(
      {required this.toLocation, required this.toCoordinates});
}

final class LocationSelectedState extends LocationState {
  final String fromLocation;
  final LatLng fromCoordinates;
  final String toLocation;
  final LatLng toCoordinates;
  final List<LatLng> polylineCoordinates;
  final String? duration;
  final String? distance;
  LocationSelectedState(
      {required this.fromLocation,
      required this.fromCoordinates,
      required this.toLocation,
      required this.toCoordinates,
      this.distance,
      this.duration,
      this.polylineCoordinates = const []});
}

// class LocationDirectionsLoadedState extends LocationState {
//   final List<LatLng> polylineCoordinates;
//   final LatLng fromCoordinates;
//   final LatLng toCoordinates;

//   LocationDirectionsLoadedState({
//     required this.polylineCoordinates,
//     required this.fromCoordinates,
//     required this.toCoordinates,
//   });
// }
