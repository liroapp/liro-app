import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:liro/data/app_exceptions/app_exceptions.dart';
import 'package:liro/utils/data_class.dart';

class ApiServices {
  static final _headers = {'Content-Type': 'application/json'};

  //Post Api
  static Future<DataClass<Map>> postApi(var data, String apiurl) async {
    if (kDebugMode) {
      print('ApiUrl:$apiurl');
      print('Data:$data');
    }
    Map fetchedData = {};
    final url = Uri.parse(apiurl);
    final body = jsonEncode(data);
    try {
      final response = await http.post(url, body: body, headers: _headers);
      fetchedData = getResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      return DataClass(appexception: e as AppException);
    }
    return DataClass(data: fetchedData);
  }

  //Get Api
  static Future<DataClass<Map>> getApi(String apiurl) async {
    if (kDebugMode) {
      print('ApiUrl:$apiurl');
    }
    final url = Uri.parse(apiurl);
    Map<String, dynamic> fetchedData = {};
    try {
      final response = await http.get(url);
      fetchedData = getResponse(response);
      if (kDebugMode) {
        print(fetchedData);
      }
    } on SocketException {
      return DataClass(appexception: InternetException());
    } on http.ClientException {
      return DataClass(appexception: RequestTimeOUtException());
    } catch (e) {
      return DataClass(appexception: e as AppException);
    }
    return DataClass(data: fetchedData);
  }

  // Put Api
  static Future<DataClass<Map>> putApi(var data, String apiurl) async {
    if (kDebugMode) {
      print('ApiUrl: $apiurl');
      print('Data: $data');
    }
    Map<String, dynamic> fetchedData = {};
    final url = Uri.parse(apiurl);
    try {
      final response = await http.put(
        url,
        body: data.isNotEmpty ? jsonEncode(data) : null,
        headers: _headers,
      );

      fetchedData = getResponse(response);
    } catch (e) {
      return DataClass(appexception: e as AppException);
    }

    return DataClass(data: fetchedData);
  }

  // Patch Api
  static Future<DataClass<Map>> patchApi(var data, String apiurl) async {
    if (kDebugMode) {
      print('ApiUrl: $apiurl');
      print('Data: $data');
    }
    Map<String, dynamic> fetchedData = {};
    final url = Uri.parse(apiurl);
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(data),
        headers: _headers,
      );

      fetchedData = getResponse(response);
    } catch (e) {
      return DataClass(appexception: e as AppException);
    }

    return DataClass(data: fetchedData);
  }

  //Responses
  static Map<String, dynamic> getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body));
      case 400:
        throw BadRequestException();
      default:
        throw BadRequestException();
    }
  }
}
