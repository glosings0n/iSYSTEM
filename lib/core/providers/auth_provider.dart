import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _nameCtr = "";
  String _emailCtr = "";
  String _passwordCtr = "";

  String get nameCtr => _nameCtr;
  String get emailCtr => _emailCtr;
  String get passwordCtr => _passwordCtr;

  // Logique pour mettre à jour lors du changement de textfield et notifier l'UI
  void changeUserName(String newValue) {
    _nameCtr = newValue.trim();
    notifyListeners();
  }

  void changeUserEmail(String newValue) {
    _emailCtr = newValue.trim();
    notifyListeners();
  }

  void changeUserPassword(String newValue) {
    _passwordCtr = newValue.trim();
    notifyListeners();
  }

  bool canViewPassword = false;

  void changeViewPasswordState() {
    canViewPassword = !canViewPassword;
    notifyListeners();
  }
}

class UserProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";

  String get name => _name;
  String get email => _email;

  // Logique pour mettre à jour et notifier l'UI
  void setUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }
}
