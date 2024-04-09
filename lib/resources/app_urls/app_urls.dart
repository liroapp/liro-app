class AppUrls {
  //Base Url
  static const String baseUrl = 'https://liroapp-server-node-js-mongob-jwt-b875-cikp.onrender.com';

  //User Login
  static const String userLogin = '$baseUrl/login';

  // Google Map Directions API
  static const String googleDirectionsAPI =
      '$baseUrl/fetch-directions';

  //Google Map Places API
  static const String googleMapPlacesAPI =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=';

  // Google Map GeoCode API
  static const String googleMapGeocodeAPI =
      'https://maps.googleapis.com/maps/api/geocode/json?place_id=';
}
