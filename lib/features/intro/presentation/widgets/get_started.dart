import 'package:covid19/features/intro/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class GetStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
          Container(
            width: size.width - 135.0,
            height: size.width - 160.0,
            margin: EdgeInsets.only(top: 50.0, bottom: 35.0),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/intro.png"), fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Text(
              "Let's get started",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,fontFamily: 'google'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Never a better time than now to start thinking about how you can save our world.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                height: 1.6,
                fontFamily: 'google'
              ),
            ),
          )
                    ],
                  ),
                ),
                /*** footer ***/
                Container(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: <Widget>[
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
                "Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'google', color: Color(0xffffffff)),
              ),
            ),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );          
            },
          ),
          GestureDetector(
                      child: Container(
              child: Text(
                "Login to Account",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'google', color: Colors.black),
              ),
            ),
            onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
            },
          ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}