import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/covid.dart';
import 'package:covid19/features/home/domain/providers/firebase_auth_provider.dart';
import 'package:covid19/features/intro/domain/providers/registration_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FirebaseUser _covidUser;
  String code1 = '';
  String code2 = '';
  String code3 = '';
  String code4 = '';
  String code5 = '';
  String code6 = '';
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Verification",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'google'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 45.0),
                      child: Text(
                        "Enter 6 digit number that sent to your phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, height: 1.6, fontFamily: 'google'),
                      ),
                    ),
                    Container(
                      width: size.width - 20.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width ,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: TextField(
                                    focusNode: focusNode1,
                                    onChanged: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode2);
                                      code1 = value;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                                Container(
                                  child: TextField(
                                    focusNode: focusNode2,
                                    onChanged: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode3);
                                      code2 = value;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                                Container(
                                  child: TextField(
                                    focusNode: focusNode3,
                                    onChanged: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode4);
                                      code3 = value;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                                Container(
                                  child: TextField(
                                    focusNode: focusNode4,
                                    onChanged: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode5);
                                      code4 = value;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                                Container(
                                  child: TextField(
                                    focusNode: focusNode5,
                                    onChanged: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode6);
                                      code5 = value;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                                Container(
                                  child: TextField(
                                    focusNode: focusNode6,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    onChanged: (String value) {
                                      code6 = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: 40.0,
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12))),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              margin: EdgeInsets.only(top: 25.0),
                              width: size.width - 90.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(100, 140, 255, 1.0),
                                borderRadius: BorderRadius.circular(180.0),
                              ),
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'google',
                                    color: Color(0xffffffff)),
                              ),
                            ),
                            onTap: () async {
                              var code =
                                  code1 + code2 + code3 + code4 + code5 + code6;
                              await FirebasePhoneAuth.signInWithPhoneNumber(
                                      smsCode: code.toString())
                                  .then((AuthResult result) async {
                                Firestore.instance
                                    .collection("users")
                                    .document(result.user.uid)
                                    .setData({
                                  "uid": result.user.uid, 
                                  "phoneNumber":result.user.phoneNumber                                
                                });
                                _covidUser = result.user;
                                var authProvider = Provider.of<AuthProvider>(
                                    context,
                                    listen: false);
                                authProvider.setCurrentUser(_covidUser);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CovidPage()),
                                  (Route<dynamic> route) => false,
                                );
                              }).catchError((error) {
                                print(error);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Re-send code in 0:30",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'google'),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
