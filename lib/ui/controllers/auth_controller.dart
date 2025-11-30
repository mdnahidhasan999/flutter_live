import 'dart:convert';

import 'package:flutter_live/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'user_token';
  static const String _userDataKey = 'user_data';

  static String accessToken = '';
  static UserModel? userData;

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserData(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));

    userData = user;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userDataString = sharedPreferences.getString(_userDataKey);
    if (userDataString != null) {
      return UserModel.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  static Future<bool> checkAuthState() async {
    String? token = await getUserToken();
    if (token == null) return false;

    accessToken = token;
    userData = await getUserData();
    return true;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userDataKey);
    accessToken = '';
    userData = null;
  }
}
