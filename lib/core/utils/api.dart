import 'package:covid19/core/utils/dio.dart';
import 'package:covid19/core/utils/youtube_api_keys.dart';
import 'package:covid19/core/utils/google_api_keys.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:google_maps_webservice/places.dart';

class Api {
  static final dio = Dio()..interceptors.add(CacheInterceptor());
  static String placeAPIUrl="https://maps.googleapis.com/maps/api/place/details/json?place_id=";   
  static Future<Map> getAllVideos(String videoURL) async {    
    for (var i = 0; i < apiKeys.length; i++) {
      var url = videoURL+apiKeys[i];
      //print(url);
      try {
        var response = await dio.get(url);
        if (response.statusCode == 200) {
          return response.data;
        }
        else if(response.statusCode==403)
        {
          continue;
        }
      } catch (e) {
        if (i >= apiKeys.length - 1) {
          return Future.error("Failed to establish connection");
        } else {
          continue;
        }
      }
    }
    return Future.error("Failed to establish connection");
  }
  static Future<PlacesDetailsResponse> getPlaceDetails(String placeid) async{

    for (var i = 0; i < googleApiKeys.length; i++) {
       GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: googleApiKeys[i]);
      //var url = placeAPIUrl+placeid+"&key="+googleApiKeys[i];
      //print(url);
      try {
        return await _places.getDetailsByPlaceId(placeid);        
      } catch (e) {
        if (i >= googleApiKeys.length - 1) {
          return Future.error("Failed to establish connection");
        } else {
          continue;
        }
      }
    }
    return Future.error("Failed to establish connection");

  }
}
