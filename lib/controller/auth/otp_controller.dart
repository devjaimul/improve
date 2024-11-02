import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:Improve.Ai/views/auth/information_of_client.dart';
import 'package:Improve.Ai/views/auth/reset_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../network caller/network_caller.dart';
import '../../utlis/urls.dart';

class OtpController extends GetxController {
  bool _isLoading = false;
  bool _isResending = false;
  final RxInt _countdown = 120.obs; // Reactive countdown
  final RxBool _isCountingDown = false.obs; // Reactive flag for countdown status

  bool get isLoading => _isLoading;
  bool get isResending => _isResending;
  int get countdown => _countdown.value;
  bool get isCountingDown => _isCountingDown.value;

  void startCountdown() {
    _isCountingDown.value = true;
    _countdown.value = 120;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown.value > 0) {
        _countdown.value--; // Automatically updates the UI
      } else {
        timer.cancel();
        _isCountingDown.value = false; // Ends countdown and enables the button
      }
    });
  }

  Future<void> verifyOtp(String otp, String userId, bool isFromSignUp) async {
    _isLoading = true;
    update();

    final response = await NetWorkCaller.postRequest(
      Urls.otpVerify,
      body: {
        "userId": userId,
        "code": otp,
      },
    );

    _isLoading = false;
    update();

    if (response.isSuccess) {
      // Extract and save the token from the response
      String? token = response.responseData['data']['token'];
      if (token != null) {
        await AuthController.saveUserAccessToken(token);
        debugPrint('Token saved successfully: $token');
        Get.snackbar("Success", "OTP verified successfully!");

        // Navigate to the appropriate screen
        if (isFromSignUp) {
          Get.offAll(() => InformationOfClient(userId: userId));
        } else {
          Get.offAll(() =>  ResetPassScreen(userId: userId,));
        }
      } else {
        Get.snackbar("Error", "Token not found in the response");
      }
    } else {
      Get.snackbar("Error", response.errorMessage ?? "OTP verification failed");
    }
  }

  Future<void> resendOtp(String userId) async {
    _isResending = true;
    update();

    final response = await NetWorkCaller.getRequest(Urls.otpResend(userId));

    _isResending = false;
    update();

    if (response.isSuccess) {
      Get.snackbar("Success", "OTP has been resent successfully!");
      startCountdown(); // Restart countdown after resending
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Failed to resend OTP");
    }
  }
}
