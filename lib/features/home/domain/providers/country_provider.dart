import 'package:covid19/features/home/domain/country.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  CountryProvider();

  Country _countryData=new Country(code: "in", name: "india");

  void setCountry(Country data) {
    _countryData = data;
    notifyListeners();
  }

  Country get getCountry => _countryData;
}