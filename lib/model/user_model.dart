import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUserId(String? id) {
    // Allow nullable String
    _userId = id;
    notifyListeners();
  }
}
