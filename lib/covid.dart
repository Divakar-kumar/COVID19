import 'package:covid19/features/home/presentation/screens/feeds_screen.dart';
import 'package:covid19/features/profile/presentations/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'core/utils/fluid_nav_bar.dart';
import 'features/entertainment/presentation/screens/entertainment_page.dart';
import 'features/location/domain/location.dart';
import 'features/location/domain/location_provider.dart';

class CovidPage extends StatefulWidget {
  CovidPage();
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  _CovidPageState();
  Widget _child;
  @override
  void initState() {   
    _child = FeedScreen(title: "COVID-19");
    super.initState();
  }
    _getCurrentLocation(context) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      var locationProvider = Provider.of<LocationProvider>(context, listen: false);
      LocationModel location=new LocationModel(latitude: position.latitude,longitude: position.longitude);
      locationProvider.setLocation(location);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
    backgroundColor: Colors.white,
    extendBody: true,
    body: _child,
    bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
        ),
      );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = FeedScreen();
          break;
        case 1:
          _child = Entertainment();
          break;
        case 2:
          /*_child = QuestionIndexPage(
                            dataSource: QuestionData.yourQuestionsAnswered,
                            title: "Questions",
                          );*/
          _child = ProfilePage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
