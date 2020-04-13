import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:covid19/features/location/domain/location_provider.dart';
import 'package:covid19/features/location/domain/marker_provider.dart';
import 'package:covid19/features/location/presentation/widgets/bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class GoogleMapUI extends StatefulWidget {  
  @override
  State<GoogleMapUI> createState() => GoogleMapUIState();
}

class GoogleMapUIState extends State<GoogleMapUI> {
  GoogleMapController controller;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();
  Set<Circle> circles = Set<Circle>();
  PlacesDetailsResponse _place;

  @override
  void initState() {
    super.initState();
  }

  void clearData() {
    markers.clear();
    polylines.clear();
    circles.clear();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future addPlace(place) async {
    //var markerProvider = Provider.of<MarkerProvider>(context);
    //var place = markerProvider.getMarker;
    if (place != null) {
      /*circles.add(createCircle(
          Colors.blueAccent,
          LatLng(place.result.geometry.location.lat,
              place.result.geometry.location.lng)));*/
      if (this.controller == null) {
        return;
      }
      controller.moveCamera(CameraUpdate.newLatLng(LatLng(
          place.result.geometry.location.lat,
          place.result.geometry.location.lng)));
      markers.clear();

      final Uint8List markerIcon =
          await getBytesFromAsset("assets/images/marker.png", 200);
      BitmapDescriptor descriptor = BitmapDescriptor.fromBytes(markerIcon);
      setState(() {
        markers.add(Marker(
          markerId: MarkerId("" + place.result.formattedAddress),
          position: LatLng(place.result.geometry.location.lat,
              place.result.geometry.location.lng),
          infoWindow: InfoWindow(
            title: place.result.name.toString(),
          ),
          onTap: () => _showModal(place),
          icon: descriptor,
        ));
      });

      //setState(() {});
    }
  }

  void _showModal(PlacesDetailsResponse place) {
   showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BookSlotBottomModal(place: place,),
    );
  }

  void _closeModal(void value) {}
  Circle createCircle(Color color, LatLng position) {
    return Circle(
        circleId: CircleId(position.toString()),
        fillColor: color,
        strokeColor: color.withOpacity(0.4),
        center: position,
        strokeWidth: 75,
        radius: 32.0,
        visible: true);
  }

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    var _place = Provider.of<MarkerProvider>(context).getMarker;
    if (_place != null) {
      addPlace(_place);
      Provider.of<MarkerProvider>(context).setMarker(null);
    }
    return Scaffold(    
      backgroundColor: Colors.transparent,
      body: new Container(
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(locationProvider.getLocation.latitude,
                locationProvider.getLocation.longitude),
            zoom: 15.4746,
          ),
          onMapCreated: (GoogleMapController controller) async {
            this.controller = controller;
            _controller.complete(controller);
          },
          myLocationButtonEnabled: true,
          markers: markers,
          polylines: polylines,
          circles: circles,
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    //controller.setMapStyle(_getFileData('assets/night_mode.json').then(_setMapStyle);)
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
