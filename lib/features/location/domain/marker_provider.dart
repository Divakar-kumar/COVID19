import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class MarkerProvider with ChangeNotifier {
  MarkerProvider();

  PlacesDetailsResponse place ;      

  void setMarker(PlacesDetailsResponse data) {
    place = data;
    notifyListeners();
  }

  PlacesDetailsResponse get getMarker => place;
}
