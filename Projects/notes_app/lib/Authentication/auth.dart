import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/Models/http_error_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Login, Signup }

class Auth extends ChangeNotifier {
  String _userId;
  String _token;
  DateTime _expiryDate;
  Timer _authtimer;
  String _username;

  bool get isAuth {
    if (token != null) {
      return true;
    }
    return false;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  String get userId {
    return _userId;
  }

  String get username {
    return _username;
  }

  Future<void> updateUserName(String newUsername) async {
    _username = newUsername;

    String _userKey = "";

    final fetchingUrl =
        'https://todoapp-5fac0.firebaseio.com/userdetails.json?auth=$_token&orderBy="userId"&equalTo="$_userId"';

    final response = await http.get(fetchingUrl);

    final jsonProduct = json.decode(response.body) as Map<String, dynamic>;
    jsonProduct.forEach(
      (key, value) {
        _userKey = key;
      },
    );

    final url =
        'https://todoapp-5fac0.firebaseio.com/userdetails/$_userKey.json?auth=$_token';

    final response2 = await http.patch(
      url,
      body: json.encode(
        {
          "userId": _userId,
          "username": newUsername,
        },
      ),
    );

    print(
      json.decode(
        response2.body,
      ),
    );

    notifyListeners();
  }

  Future<void> fetchingUserName() async {
    final url2 =
        'https://todoapp-5fac0.firebaseio.com/userdetails.json?auth=$_token&orderBy="userId"&equalTo="$_userId"';
    final response = await http.get(url2);
    final jsonProduct = json.decode(response.body) as Map<String, dynamic>;
    jsonProduct.forEach((key, value) {
      _username = value["username"];
    });
  }

  Future<void> _authentication(
      String email, String password, String urlSegment, Status status,
      [String username]) async {
    try {
      final url = urlSegment;

      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));

      final responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        print(responseData["error"]);

        throw HttpErrorGenerator(errorMessage: "Error Occured");
      }

      _userId = responseData["localId"];
      _token = responseData["idToken"];

      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));

      autoLogOut();

      if (status == Status.Signup) {
        final url1 =
            'https://todoapp-5fac0.firebaseio.com/userdetails.json?auth=$_token';

        _username = username;

        await http.post(url1,
            body: json.encode({"userId": _userId, "username": username}));
      }

      if (status == Status.Login) {
        fetchingUserName();
      }

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String()
      });

      prefs.setString("userData", userData);
    } catch (erorr) {
      print(erorr);
      throw (erorr);
    }
  }

  Future<void> signUp(String email, String password, String requiredUserName) {
    return _authentication(
        email,
        password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBHuiQ2CkXffAQKIa5Su_J2P4uAuMngq4o',
        Status.Signup,
        requiredUserName);
  }

  Future<void> signIn(String email, String password) {
    return _authentication(
        email,
        password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBHuiQ2CkXffAQKIa5Su_J2P4uAuMngq4o',
        Status.Login);
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }

  void autoLogOut() {
    if (_authtimer != null) {
      _authtimer.cancel();
    }

    final timer = _expiryDate.difference(DateTime.now()).inSeconds;

    _authtimer = Timer(Duration(seconds: timer), logout);
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("userData")) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString("userData")) as Map<String, dynamic>;
    final newExpiryDate = DateTime.parse(extractedUserData["expiryDate"]);

    if (newExpiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _userId = extractedUserData["userId"];
    _token = extractedUserData["token"];
    _expiryDate = newExpiryDate;

    fetchingUserName();
    notifyListeners();
    autoLogOut();
    return true;
  }
}
