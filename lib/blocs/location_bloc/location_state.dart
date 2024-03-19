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
  FromLocationSelectedState({required this.fromLocation, required this.fromCoordinates});
}

final class ToLocationSelectedState extends LocationState {
  final String toLocation;
  final LatLng toCoordinates;
  ToLocationSelectedState({required this.toLocation, required this.toCoordinates});
}


final class LocationSelectedState extends LocationState {
  final String fromLocation;
  final LatLng fromCoordinates;
  final String toLocation;
  final LatLng toCoordinates;
  LocationSelectedState({required this.fromLocation, required this.fromCoordinates, required this.toLocation, required this.toCoordinates});
}