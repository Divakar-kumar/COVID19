import 'package:covid19/features/location/domain/location.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider();

  LocationModel _location=new LocationModel(latitude: 12.9360787,longitude:80.2110261);

  void setLocation(LocationModel data) {
    _location = data;
    notifyListeners();
  }

  LocationModel get getLocation => _location;
}