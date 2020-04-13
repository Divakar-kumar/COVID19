import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbyPlacePage extends StatefulWidget {
  @override
  _NearbyPlacePageState createState() => _NearbyPlacePageState();
}

class _NearbyPlacePageState extends State<NearbyPlacePage> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
     _getCurrentLocation();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
               
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {        
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}