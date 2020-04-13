import 'package:covid19/features/intro/domain/providers/registration_provider.dart';
import 'package:covid19/features/intro/presentation/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String phoneNumber;
  String phoneIsoCode = '+91';
  bool visible = false;
  String confirmedNumber = '';  
  void onPhoneNumberChange(String number) {
    print(number);
    setState(() {
      phoneNumber = number;
    });
  }
    void onPhoneNumberChangeTest(PhoneNumber number) {
    print(number);
    setState(() {
      phoneNumber = number.phoneNumber;
    });
  }
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
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Registration",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'google'),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 45.0),
                child: Text(
                  "Enter your mobile number, we will send you OTP to verify later",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0, height: 1.6, fontFamily: 'google'),
                ),
              ),
              Container(
                width: size.width - 20,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 13.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /*Container(
                              width: size.width - 210,
                              child: 
                              TextFormField(
                                onChanged: onPhoneNumberChange,   
                                keyboardType: TextInputType.phone,                             
                                decoration: InputDecoration(labelText: '(+91) 8128008011', border: InputBorder.none)),
                              ),*/
                          Container(
                            width: size.width - 170,
                            child: InternationalPhoneNumberInput(
                              isEnabled: true,
                              autoValidate: true,                            
                              formatInput: false,
                              initialCountry2LetterCode: 'IN',
                              hintText: 'Invalid phone number',
                              onInputChanged: onPhoneNumberChangeTest,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        margin: EdgeInsets.only(top: 30.0),
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
                              fontFamily: 'google',
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff)),
                        ),
                      ),
                      onTap: () async{
                        var result= await FirebasePhoneAuth.instantiate(phoneNumber: phoneNumber);                     
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerificationScreen()),
                        );
                      },
                    ),
                  ],
                ),
              )
            ])),
          ],
        ),
      ),
    );
  }
}
