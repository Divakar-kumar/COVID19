import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/core/utils/circle_percentage_widget.dart';
import 'package:covid19/core/utils/dio.dart';
import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/scaling_info.dart';

import 'package:covid19/features/home/domain/providers/firebase_auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:covid19/features/home/domain/providers/country_provider.dart';

 final dio = Dio()
  ..interceptors.add(CacheInterceptor());
Future<Map> getGlobalStatistics(countryData) async {
  var url = "http://api.coronastatistics.live/countries/${countryData.name}";
  var response = await dio.get(url);  
  var responseData;
  if (response.statusCode == 200) {
    if (response.data == "false") {
      responseData = {"country": "${countryData.name}"};
      return responseData;
    } else {
      responseData = response.data;
      return responseData;
    }
  } else {
    return Future.error("Please check your network connection");
  }
}




class GlobalStats extends StatefulWidget {  
  GlobalStats();
  @override
  _GlobalStatsState createState() => _GlobalStatsState();
}

class _GlobalStatsState extends State<GlobalStats> {

  dynamic _getGlobalStats;
  Future<void> _getCurrentUser;
  var currentUser;
  var countryData;
  _GlobalStatsState();
  var defaultCountryData;
  @override
  void initState() {    
    super.initState(); 
   // _signInAnonymously(context);   
  }

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FirebaseUser _covidUser;
  Future<void> _signInAnonymously(context) async {
    try {
      var authResponse=await firebaseAuth.signInAnonymously();
      _covidUser=authResponse.user; 
      var authProvider=Provider.of<AuthProvider>(context,listen: false);  
      authProvider.setCurrentUser(_covidUser);         
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {   
    setState(() {
        currentUser=Provider.of<AuthProvider>(context).getSignedInUser?.uid;
      });
     final countryProvider=Provider.of<CountryProvider>(context);
    final countryData=countryProvider.getCountry;
     //_signInAnonymously(context);
     _getGlobalStats = getGlobalStatistics(countryData);
    return FutureBuilder<Map>(
            future: _getGlobalStats,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Center(child: Text("Connection Not Found"));
                case ConnectionState.waiting:
                  return Center(
                      child: SpinKitThreeBounce(
                    size: 24.0,
                    itemBuilder: (_, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: blackBlueGradient, shape: BoxShape.circle),
                      );
                    },
                  ));
                default:
                  if (snapshot.hasError) {
                    return new Center(
                      child: Text("Error : ${snapshot.error}"),
                    );
                  }
                  var getAllData = snapshot.data;
                  if (getAllData.length > 1) {
                    var totalCases = getAllData["cases"];
                    var totalDeaths = getAllData["deaths"];
                    var totalRecoveries = getAllData["recovered"];
                    var totalCritical = getAllData["critical"];
                    var todayCases = getAllData["todayCases"];
                    var todayDeaths = getAllData["todayDeaths"];
                    var activeCases = getAllData["active"];                
                    var finishedCases = totalDeaths + totalRecoveries;
                    return Container(
                      height: 120 * ScalingInfo.scaleY,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: countryData.code != null
                                    ? 'https://www.countryflags.io/${countryData.code}/shiny/64.png'
                                    : 'https://www.countryflags.io/in/shiny/64.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'CORONA OUTBREAK -${countryData.name.toString().toUpperCase()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'google',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CirclePercentageWidget(
                                  title: '$activeCases ' + ' Active',
                                  percent: (100 - (totalCritical / activeCases))
                                      .toDouble(),
                                  color0: const Color(0xFF0099CC),
                                  color1: const Color(0xFF99FF66),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$totalRecoveries' + ' Recovered',
                                  percent:
                                      (totalRecoveries / totalCases).toDouble(),
                                  color0: const Color(0xFF0099CC),
                                  color1: const Color(0xFF99FF66),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$totalDeaths ' + ' Total Deaths',
                                  percent: (totalDeaths / finishedCases).toDouble(),
                                  color0: const Color(0xFFF6356F),
                                  color1: const Color(0xFFFF5F50),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$totalCases ' + ' Total Cases',
                                  percent: (totalCases).toDouble(),
                                  color0: const Color(0xFFFF9B30),
                                  color1: const Color(0xFFF8FF3F),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$todayCases ' + ' Today Cases',
                                  percent: (todayCases / activeCases).toDouble(),
                                  color0: const Color(0xFF0099CC),
                                  color1: const Color(0xFF99FF66),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$totalCritical ' + ' Critical',
                                  percent: (totalCritical / activeCases).toDouble(),
                                  color0: const Color(0xFFF6356F),
                                  color1: const Color(0xFFFF5F50),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CirclePercentageWidget(
                                  title: '$todayDeaths ' + ' Today Deaths',
                                  percent: (todayDeaths / activeCases).toDouble(),
                                  color0: const Color(0xFFF6356F),
                                  color1: const Color(0xFFFF5F50),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                        height: 120 * ScalingInfo.scaleY,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CachedNetworkImage(
                                    imageUrl: countryData.code != null
                                        ? 'https://www.countryflags.io/${countryData.code}/shiny/64.png'
                                        : 'https://www.countryflags.io/in/shiny/64.png',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'CORONA STATISTICS',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'google',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ]));
                  }
              }
            });
  }
}
