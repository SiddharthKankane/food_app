import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _username;
  String? _email;
  String? _phone;
  String? _address;

  String? get userId => _userId;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;

  void setUserSession({
    required String userId,
    required String username,
    required String email,
    required String phone,
    required String address,
  }) {
    _userId = userId;
    _username = username;
    _email = email;
    _phone = phone;
    _address = address;
    notifyListeners();
  }

  // Support for existing code that only passes userId
  void login(String userId) {
    _userId = userId;
    _username = userId;
    _email = "$userId@testkraft.com";
    _address = "Delhi, India";
    notifyListeners();
  }

  void logout() {
    _userId = null;
    _username = null;
    _email = null;
    _phone = null;
    _address = null;
    notifyListeners();
  }
}
