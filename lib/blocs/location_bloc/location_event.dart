part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class SearchLocationEvent extends LocationEvent {
  final String searchTerm;
  SearchLocationEvent({required this.searchTerm});
}

class LocationFromCoordinatesEvent extends LocationEvent {
  final String placeId;

  LocationFromCoordinatesEvent({required this.placeId});
}

class LocationToCoordinatesEvent extends LocationEvent {
  final String placeId;

  LocationToCoordinatesEvent({required this.placeId});
}

class LocationCoordinatesEvent extends LocationEvent {
  final String placeId;
  final bool isFromCoordinates;
  LocationCoordinatesEvent({required this.placeId, required this.isFromCoordinates});
}

class LocationGetDirectionsEvent extends LocationEvent {
  // final LatLng fromCoordinates;
  // final LatLng toCoordinates;

  LocationGetDirectionsEvent();
}
