import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user_data';
  static String? accessToken;
  static User? userData;

  static Future<void> saveUserAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    debugPrint('Retrieved access token: $accessToken');
    return accessToken;
  }

  static Future<void> saveUserData(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    userData = user;
  }

  static Future<User?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDataKey);
    if (data == null) return null;

    userData = User.fromJson(jsonDecode(data));
    return userData;
  }

  static String? getUserId() {
    return userData?.id; // Make sure `userId` is a property in your `User` model
  }

  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userData = null;
  }

  static Future<bool> checkAuthState() async {
    String? token = await getUserAccessToken();
    if (token == null) return false;

    accessToken = token;
    userData = await getUserData();
    return true;
  }

  static Future<void> handleLoginResponse(String response) async {
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final loginModel = LoginModel.fromJson(jsonResponse);

    if (loginModel.data?.token != null) {
      await saveUserAccessToken(loginModel.data!.token!);
    }

    if (loginModel.data?.user != null) {
      await saveUserData(loginModel.data!.user!);
    }
  }
}
