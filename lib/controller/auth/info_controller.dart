import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:get/get.dart';




class InformationController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateUserInfo({
    required String userId,
    required String address,
    required int age,  // Ensure this is an integer
    required String height,
    required String weight,
    required String gender,
  }) async {
    isLoading.value = true;

    final response = await NetWorkCaller.putRequest(
      Urls.updateUser(userId),
      body: {
        "address": address,
        "age": age,  // Send age as an integer
        "height": double.tryParse(height) ?? 0, // Ensure numeric conversion
        "weight": double.tryParse(weight) ?? 0, // Ensure numeric conversion
        "gender": gender,
      },
    );

    isLoading.value = false;

    if (response.isSuccess) {
      Get.offAllNamed(RouteNames.navBar);
      Get.snackbar('Success', 'User information updated successfully!',
          );
    } else {
      Get.snackbar(
        'Error',
        response.errorMessage ?? 'Failed to update user information',
      );
    }
  }

}
