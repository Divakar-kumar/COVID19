import 'package:covid19/features/location/presentation/screens/google_map_hospital.dart';
import 'package:flutter/material.dart';


class Symptom extends StatelessWidget {
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
                  "Do you have these symptoms ?",
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
                      image: AssetImage("assets/images/feeling.png"),
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
                  "Visit Hospital !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'google', color: Color(0xffffffff)),
                ),
              ),
              onTap: () {               
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalMapPage()),
            );           
              }                       
            ),
            ]))
          ])),
    );
  }
}
