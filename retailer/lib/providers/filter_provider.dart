import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  final List<String> _locations = [];
  final List<String> _industries = [];
  final List<double> _range = [1, 1000000];

  List<String> get locations => [..._locations];
  List<String> get industries => [..._industries];
  List<double> get range => [..._range];

  void editLocations(List<String> locations) {
    _locations.clear();
    _locations.addAll(locations);
    notifyListeners();
  }

  void editIndustries(List<String> industries) {
    _industries.clear();
    _industries.addAll(industries);
    notifyListeners();
  }

  void editRange(double min, double max) {
    _range.clear();
    _range.add(min);
    _range.add(max);
    notifyListeners();
  }
}
