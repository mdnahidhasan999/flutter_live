import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/network-response.dart';
import 'package:http/http.dart';

import '../../app.dart';
import '../../ui/controllers/auth_controller.dart';
import '../../ui/screens/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    Response res = await get(
      Uri.parse(url),
      headers: {'token': AuthController.accessToken},
    );
    debugPrint(res.body);
    debugPrint(res.statusCode.toString());
    try {
      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body);
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (res.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: false,
          responseData: null,
        );
      } else {
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: false,
          responseData: null,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Response res = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken,
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final decodedData = jsonDecode(res.body);
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (res.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: false,
          responseData: null,
        );
      } else {
        return NetworkResponse(
          statusCode: res.statusCode,
          isSuccess: false,
          responseData: null,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> redirectToLogin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false,
    );
  }
}

//23
