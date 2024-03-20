import 'package:liro/core/keys.dart';
import 'package:liro/data/network/network_api_services.dart';
import 'package:liro/resources/app_urls/app_urls.dart';
import 'package:liro/utils/data_class.dart';

class LocationRepo {
  Future<DataClass> getLocationSearchResults(String searchTerm) async =>
      ApiServices.getApi(
          '${AppUrls.googleMapPlacesAPI}$searchTerm&key=$googleMapApiKey');
  Future<DataClass> getLocationCoordinates(String placeId) async =>
      ApiServices.getApi(
          '${AppUrls.googleMapGeocodeAPI}$placeId&key=$googleMapApiKey');
  Future<DataClass> getDirections(var directions) async => ApiServices.postApi(
        directions,
        AppUrls.googleDirectionsAPI,
      );
}
