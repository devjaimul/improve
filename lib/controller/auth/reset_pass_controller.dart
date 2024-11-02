import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:get/get.dart';
import '../../utlis/urls.dart';
import '../../routes/routes_name.dart';

class ResetPassController extends GetxController {
  var isLoading = false.obs;

  Future<void> resetPassword(String userId, String newPassword, {String? oldPassword}) async {
    if (newPassword.isEmpty) {
      Get.snackbar('Error', 'New password cannot be empty');
      return;
    }
    if (newPassword.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long');
      return;
    }

    isLoading.value = true;
    final response = await NetWorkCaller.patchRequest(
      Urls.resetPass(userId),
      body: {
        if (oldPassword != null && oldPassword.isNotEmpty) 'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );
    isLoading.value = false;

    if (response.isSuccess) {
      Get.snackbar('Success', 'Password reset successful!');
      Get.offAllNamed(RouteNames.signInScreen);
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Failed to reset password');
    }
  }
}
