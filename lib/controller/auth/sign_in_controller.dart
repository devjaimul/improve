import 'dart:convert';

import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/utlis/app_constant.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;

  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }
    if (!AppConstant.emailValidator.hasMatch(email)) {
      Get.snackbar('Error', 'Invalid email format');
      return;
    }
    if (password.length < AppConstant.passwordMinLength) {
      Get.snackbar('Error', 'Password should be at least ${AppConstant.passwordMinLength} characters');
      return;
    }

    isLoading.value = true;
    final response = await NetWorkCaller.postRequest(
      Urls.login,
      body: {
        'email': email,
        'password': password,
      },
    );
    isLoading.value = false;

    if (response.isSuccess) {
      String? token = response.responseData['data']['token'];
      if (token != null) {
        await AuthController.saveUserAccessToken(token);
        await AuthController.handleLoginResponse(jsonEncode(response.responseData));
        Get.offAllNamed(RouteNames.navBar);
        Get.snackbar('Success', 'Login successful!');
      } else {
        Get.snackbar('Error', 'Token not found in response');
      }
    } else {
     Get.snackbar('Error', response.errorMessage ?? 'Login failed');
    }
  }
}
