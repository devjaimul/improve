import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/views/auth/otp_verification_screen.dart';
import 'package:get/get.dart';
import '../../network caller/network_caller.dart';
import '../../utlis/app_constant.dart';
import '../../utlis/urls.dart';

class SignUpController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    if (!_validateEmail(email)) {
      Get.snackbar("Error", AppString.invalidEmailMessage);
      return;
    }
    if (!_validatePassword(password)) {
      Get.snackbar("Error", AppString.shortPasswordMessage);
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar("Error", AppString.passwordMismatchMessage);
      return;
    }

    _isLoading.value = true;

    final response = await NetWorkCaller.postRequest(
      Urls.registration,
      body: {
        'email': email,
        'password': password,
        'name': name,
      },
    );

    _isLoading.value = false;

    if (response.isSuccess) {
      final responseData = response.responseData;
      final userId = responseData['data']?['id'];

      if (userId != null) {
        Get.offAll(() => OtpVerificationScreen(userId: userId, isFromSignUp: true));
        Get.snackbar("Success", "Registration successful! Please verify your OTP.");
      } else {
        Get.snackbar("Error", "Unable to retrieve user ID");
      }
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Registration failed");
    }
  }

  bool _validateEmail(String email) {
    return AppConstant.emailValidator.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= AppConstant.passwordMinLength;
  }
}
