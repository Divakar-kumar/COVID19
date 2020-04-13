import 'package:covid19/features/entertainment/presentation/screens/entertainment_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HelpDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Container(
                child: Column(children: <Widget>[
              Container(
              margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Do you want to help our doctors ?",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'google'),
                ),
              ),
                       
              Container(
                width: size.width - 135.0,
                height: size.width - 160.0,
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/helpdoctor.png"),
                      fit: BoxFit.fitWidth),
                ),
              ),
               GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                margin: EdgeInsets.only(bottom: 30.0),
                width: size.width - 50.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 140, 255, 1.0),
                  borderRadius: BorderRadius.circular(180.0),
                ),
                child: Text(
                  "Stay Home & Stay Safe !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'google', color: Color(0xffffffff)),
                ),
              ),
              onTap: () {
               Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child:Entertainment()));                         
              },
            ),
            ]))
          ])),
    );
  }
}
