import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/navigation_bar.dart';
import 'package:covid19/features/location/presentation/widgets/map.dart';
import 'package:covid19/features/location/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HospitalMapPage extends StatelessWidget {
  HospitalMapPage({this.title});  
  final String title;
  @override
  Widget build(BuildContext context) {
    if (!ScalingInfo.initialized) {
      ScalingInfo.init(context);
    }
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GoogleMapUI(),
          NavigationBar(),
          SearchMapBar(title: 'Search for any Hospitals..',),
          SizedBox(height: 40),          
        ],
      ),
    );
  }
}
