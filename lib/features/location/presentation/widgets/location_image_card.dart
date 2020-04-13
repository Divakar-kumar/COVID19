import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
class LocationImageCard extends StatelessWidget {
  Photo photo;
  LocationImageCard(this.photo);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
      alignment: Alignment.center,
      child: new Container(
        height: 100.0,
        width: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 5.0,
              offset: Offset(2.0, 3.0)
            )
          ]
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: CachedNetworkImage(imageUrl:photo.photoReference!=null?"https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference="+photo.photoReference+"&sensor=false&key=YOUR_APIKEY":'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',fit: BoxFit.cover,alignment: Alignment.center,),
      ),
      ),
  
    ),
    
      ],
    );
  }
}