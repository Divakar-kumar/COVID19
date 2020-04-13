import 'package:covid19/core/utils/header_view.dart';
import 'package:covid19/features/entertainment/presentation/widgets/Badminton.dart';
import 'package:covid19/features/entertainment/presentation/widgets/craftworks.dart';
import 'package:covid19/features/entertainment/presentation/widgets/cricket.dart';
import 'package:covid19/features/entertainment/presentation/widgets/feed.dart';
import 'package:covid19/features/entertainment/presentation/widgets/football.dart';
import 'package:covid19/features/entertainment/presentation/widgets/gym.dart';
import 'package:flutter/material.dart';

class Entertainment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(      
      child: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,              
              backgroundColor: Colors.white,
              flexibleSpace: Header(
                'STAY HOME',
              ),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Feeds",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Gym",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Cricket",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Parenting",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Football",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                    Container(
                    margin: EdgeInsets.only(top:20),
                    height: 30.0,
                    child: new Container(
                        width:100,
                        height:100,                        
                        child: Text("Badminton",softWrap: false,style: TextStyle(fontFamily: "google",fontSize: 16.0,fontWeight: FontWeight.bold))                   
                    ),
                  ),
                ],
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey[400],
                indicatorWeight: 4.0,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromRGBO(215, 225, 255, 1.0),
              ),
            ),
            body: TabBarView(
              children: <Widget>[  
              FeedPage(),             
               GymPage(),
               CricketPage(),
               CraftWorkPage(),
               FootballPage(),
               BadmintonPage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
