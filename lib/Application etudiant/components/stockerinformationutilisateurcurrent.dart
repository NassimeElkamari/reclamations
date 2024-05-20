import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _prefs;

  SharedPreferencesManager._();

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> storeUserData(String nom, String prenom, String email, String sexe, String filiere, int apoge) async {
    await _prefs.setString('nom', nom);
    await _prefs.setString('prenom', prenom);
    await _prefs.setString('email', email);
    await _prefs.setString('sexe', sexe);
    await _prefs.setString('filiere', filiere);
    await _prefs.setInt('apoge', apoge);
  }

  String? getNom() {
    return _prefs.getString('nom');
  }

  String? getPrenom() {
    return _prefs.getString('prenom');
  }

  String? getEmail() {
    return _prefs.getString('email');
  }

  String? getSexe() {
    return _prefs.getString('sexe');
  }

  String? getFiliere() {
    return _prefs.getString('filiere');
  }

  int? getApoge() {
    return _prefs.getInt('apoge');
  }

  Future<void> clearUserData() async {
    await _prefs.clear();
  }
}
