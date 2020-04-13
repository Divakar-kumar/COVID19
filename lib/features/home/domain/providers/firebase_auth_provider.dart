import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth firebaseAuth;
  FirebaseUser _covidUser;
  AuthProvider();
  void setCurrentUser(FirebaseUser user) {
    _covidUser=user;
    notifyListeners();
    }

  FirebaseUser get getSignedInUser
  {
    return _covidUser;
  }
  
}