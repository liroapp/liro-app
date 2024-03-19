import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liro/core/keys.dart';
import 'package:liro/data/network/network_api_services.dart';
import 'package:liro/resources/app_urls/app_urls.dart';
import 'package:liro/utils/data_class.dart';

class LocationRepo {
  Future<DataClass>getLocationSearchResults(String searchTerm) async => ApiServices.getApi(
      '${AppUrls.googleMapPlacesAPI}$searchTerm&key=$googleMapApiKey');
   Future<DataClass>getLocationCoordinates(String placeId) async => ApiServices.getApi(
      '${AppUrls.googleMapGeocodeAPI}$placeId&key=$googleMapApiKey');
    Future<DataClass>getDirections(LatLng fromCoordinates, LatLng toCoordinates) async => ApiServices.getApi(
      '${AppUrls.googleDirectionsAPI}origin=${fromCoordinates.latitude},${fromCoordinates.longitude}&destination=${toCoordinates.latitude},${toCoordinates.longitude}&mode=driving&key=$googleMapApiKey');
}
