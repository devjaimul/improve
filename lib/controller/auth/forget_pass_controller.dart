import 'package:Improve.Ai/views/auth/otp_verification_screen.dart';
import 'package:get/get.dart';
import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/utlis/urls.dart';

class ForgetPassController extends GetxController {
  var isLoading = false.obs;

  Future<void> sendForgetPasswordRequest(String email) async {
    isLoading.value = true;

    final response = await NetWorkCaller.postRequest(
      Urls.forgetPass,
      body: {"email": email},
    );

    isLoading.value = false;

    if (response.isSuccess) {
      String? userId = response.responseData['data']['id'];
      if (userId != null) {
        Get.snackbar("Success", "OTP sent to your email!");
        Get.offAll(() => OtpVerificationScreen(userId: userId, isFromSignUp: false));
      } else {
        Get.snackbar("Error", "User ID not found in the response.");
      }
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Failed to send OTP.");
    }
  }
}
