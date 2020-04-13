import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/home/presentation/widgets/category_list.dart';
import 'package:covid19/features/home/presentation/widgets/helpdoctor.dart';
import 'package:covid19/features/home/presentation/widgets/navigation_bar.dart';
import 'package:covid19/features/home/presentation/widgets/search_bar.dart';
import 'package:covid19/features/home/presentation/widgets/shopping_screen.dart';
import 'package:covid19/features/home/presentation/widgets/stats.dart';
import 'package:covid19/features/home/presentation/widgets/symptoms.dart';
import 'package:covid19/features/home/presentation/widgets/wash_hands.dart';
import 'package:covid19/features/home/presentation/widgets/who_news.dart';
import 'package:covid19/features/home/presentation/widgets/who_videos.dart';
import 'package:covid19/features/home/presentation/widgets/workfromhome.dart';
import 'package:flutter/material.dart';

//Home Feed screen
class FeedScreen extends StatelessWidget {
  //Constructor
  FeedScreen({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    if (!ScalingInfo.initialized) {
      ScalingInfo.init(context);
    }
      Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AppBackground(),
            NavigationBar(),
            SearchBar(title: 'Search for any Countries..',),
            SizedBox(height: 40),
            Positioned.fill(
                top: 120 * ScalingInfo.scaleY,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: new ListView(children: <Widget>[
                      new GestureDetector(
                          child: Container(
                              height: 180 * ScalingInfo.scaleX,
                              child: GlobalStats())),
                      ShoppingScreen(),                    
                      CategoryList(),
                      WashHands(),
                      WhoVideosPage(),
                      WorkFromHome(),
                      SizedBox(height: 20),
                      WhoNewsPage(),
                      SizedBox(height: 20),
                      Symptom(),
                     // SizedBox(height: 20),
                     // HelpDoctor()
                    ])))
          ],
        ),
      ),
    );
  }
}
