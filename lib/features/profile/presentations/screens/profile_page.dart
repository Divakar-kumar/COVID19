import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/profile_navigation_bar.dart';
import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/home/presentation/widgets/category_list.dart';
import 'package:covid19/features/home/presentation/widgets/navigation_bar.dart';
import 'package:covid19/features/home/presentation/widgets/who_videos.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(      
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppBackground(),
          NavigationBar(),
          SizedBox(height: 40),
        Positioned(
          top: 50,
          left: 150,
          right: 150,
                  child: Column(
                    children: <Widget>[
                      Center(child: 
              Image.asset("assets/images/avatar.png",height: 80,width: 80,)),
              //  Container(
              //                                     height: 35.0,
              //                                     width: 100,                                                  
              //                                     padding: EdgeInsets.symmetric(
              //                                         horizontal: 16.0),
              //                                     margin: EdgeInsets.only(
              //                                         top:10.0),
              //                                     decoration: BoxDecoration(
              //                                       gradient: redSexyGradient,
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               15.0),
              //                                     ),
              //                                     child: Center(
              //                                       child: Text(
              //                                         'Log In',
              //                                         style: TextStyle(
              //                                           color: Colors.white,
              //                                           fontWeight:
              //                                               FontWeight.w900,
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
                    ],
                  ),
        ),
          Positioned.fill(
              top: 120 * ScalingInfo.scaleY,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: new ListView(children: <Widget>[
                    SizedBox(height: 20),
                    Container(child: CategoryList()),
                    WhoVideosPage(),
                    SizedBox(height: 20),
                  ]))),
          Container()
        ],
      ),
    );
  }
}
