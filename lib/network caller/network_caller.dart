import 'dart:convert';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/auth_controller.dart';
import 'network_response.dart';

class NetWorkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      debugPrint('GET Request URL: $url');
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${AuthController.accessToken ?? ""}',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: true, responseData: decodedData);
      } else if (response.statusCode == 401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false, errorMessage: 'Unauthorized');
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Error: ${response.body}');
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      debugPrint('POST Request URL: $url');
      debugPrint('Request Body: ${jsonEncode(body)}');

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${AuthController.accessToken ?? ""}',
        },
        body: jsonEncode(body),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: true, responseData: decodedData);
      } else if (response.statusCode == 401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false, errorMessage: 'Unauthorized');
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Error: ${response.body}');
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> putRequest(String url, {Map<String, dynamic>? body}) async {
    if (AuthController.accessToken == null || AuthController.accessToken!.isEmpty) {
      debugPrint('Authorization token is missing!');
      return NetworkResponse(
          statusCode: 401, isSuccess: false, errorMessage: 'Authorization token is missing');
    }

    try {
      debugPrint('PUT Request URL: $url');
      debugPrint('Request Body: ${jsonEncode(body)}');

      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${AuthController.accessToken}',
        },
        body: jsonEncode(body),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        final decodedData = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: true, responseData: decodedData);
      } else if (response.statusCode == 401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false, errorMessage: 'Unauthorized');
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Error: ${response.body}');
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> patchRequest(String url, {Map<String, dynamic>? body}) async {
    if (AuthController.accessToken == null || AuthController.accessToken!.isEmpty) {
      debugPrint('Authorization token is missing!');
      return NetworkResponse(
          statusCode: 401, isSuccess: false, errorMessage: 'Authorization token is missing');
    }

    try {
      debugPrint('API URL: $url');
      debugPrint('Request Body: ${jsonEncode(body)}');
      debugPrint('Authorization Token: ${AuthController.accessToken}');

      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${AuthController.accessToken}',
        },
        body: jsonEncode(body),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        final decodedData = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: true, responseData: decodedData);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false, errorMessage: 'An error occurred: ${response.body}');
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<void> redirectLogin() async {
    await AuthController.clearAllData();
    Get.offAllNamed(RouteNames.signInScreen);
  }
}
