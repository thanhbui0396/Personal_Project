import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token = '';
  int _expires = 0;
  late Timer timer;

  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authentication(
      String email, String password, String type) async {
    const url = 'https://apiforlearning.zendvn.com/api/auth/login';
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({"email": email, "password": password}));
      final responseData = jsonDecode(response.body);
      _token = responseData['access_token'];
      _expires = responseData['expires_in'];

      //lấy time hiện tại
      DateTime timenow = DateTime.now();
      DateTime timeExprires = timenow.add(Duration(seconds: _expires));
      startTokenTimer(timeExprires);
      notifyListeners();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
          {'token': _token, 'expires': timeExprires.toIso8601String()});
      await prefs.setString('userData', userData);
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) {
    _authentication(email, password, 'login');
  }

  Future<void> logout() async {
    _token = '';
    _expires = 0;
    notifyListeners();
    stopTokenTimer();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<bool> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final data = jsonDecode(prefs.getString('userData') ?? '');
    DateTime expires = DateTime.parse(data['expires']);
    startTokenTimer(expires);
    return true;
  }

  Future<void> checkTimeExpires() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString('userData') ?? '');
    DateTime expires = DateTime.parse(data['expires']);
    if (DateTime.now().isAfter(expires)) {
      logout();
    }
  }

  void startTokenTimer(DateTime timeExprires) {
    var timeUntil = timeExprires.difference(DateTime.now());
    timer = Timer(timeUntil, checkTimeExpires);
  }

  void stopTokenTimer() {
    timer.cancel();
  }
}
