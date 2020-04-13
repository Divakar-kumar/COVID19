import 'package:covid19/core/utils/google_api_keys.dart';
import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/location/domain/location_provider.dart';
import 'package:covid19/features/location/domain/marker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:covid19/core/utils/api.dart';

class SearchMapBar extends StatefulWidget {
  SearchMapBar({this.title = ''});

  String title;

  @override
  _SearchMapBarState createState() => _SearchMapBarState();
}

class _SearchMapBarState extends State<SearchMapBar> {
  int nextApiIndex=0;
  void onError(PlacesAutocompleteResponse response) {
    print(response);    
    // if(nextApiIndex < googleApiKeys.length) {
    //   nextApiIndex++;
    //   Navigator.of(context).pop('dialog');
    //   _handlePressButton(googleApiKeys[nextApiIndex]);      
    // }
  }

  Future<void> _handlePressButton(googleApikey) async {
    try {
      var locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      final center = locationProvider.getLocation;
      try
      {
      Prediction p = await PlacesAutocomplete.show(        
          context: context,        
          strictbounds: center == null ? false : true,
          apiKey: "YOUR_API_KEY",
          onError: onError,                
          mode: Mode.overlay,         
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 100000);
      displayPrediction(p);
      }
      catch(e)
      {

      }
    } catch (e) {
      return;
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      try
      {
      PlacesDetailsResponse detail = await Api.getPlaceDetails(p.placeId.toString());
      //PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId.toString());
      var markerProvider = Provider.of<MarkerProvider>(context, listen: false);
      markerProvider.setMarker(detail);
      setState(() {
        widget.title = detail.result.name.toString();
      });

      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      print(lat);
      print(lng);
      }
      catch(ex)
      {
        print(ex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[Positioned(
        top: 50 * ScalingInfo.scaleY,
        left: 10,
        right: 10,
        child: new Container(
            alignment: Alignment.center,
            height: 60.0,
            width: MediaQuery.of(context).size.width - 95,
            child: InkWell(
              onTap:()=> _handlePressButton("AIzaSyDQbpQmEBViCytODXb81YQu2AzXqPnkkaQ"),
              child: new Card(
                  elevation: 18.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(left: 14.0)),
                        Expanded(
                          child: new Text(
                            widget.title,
                            style: TextStyle(
                                fontFamily: 'google',
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                        new Icon(Icons.search),
                        new Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                        )
                      ],
                    ),
                  )),
            )),
      ),
          ]);
  }
}
