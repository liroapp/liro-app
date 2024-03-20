part of 'location_bloc.dart';

@immutable
abstract class LocationState {
  get distance => null;
}

final class LocationInitial extends LocationState {}

final class LocationSearchSuccessState extends LocationState {
  final List<dynamic> fromPredictions;
  LocationSearchSuccessState({required this.fromPredictions});
}

final class LocationSearchErrorState extends LocationState {
  final String error;
  LocationSearchErrorState({required this.error});
}



final class LocationSelectedState extends LocationState {
  final String fromLocation;
  final LatLng fromCoordinates;
  final String toLocation;
  final LatLng toCoordinates;
  final List<LatLng> polylineCoordinates;
  final String? duration;
  // ignore: annotate_overrides
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
