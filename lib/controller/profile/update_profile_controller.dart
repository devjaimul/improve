import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class UpdateProfileController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateProfile({
    required String userId,
    required String name,
    required String address,
    required String gender,
    required int age,
    required double height,
    required double weight,
    File? profileImage, // Add this parameter for the image
  }) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(Urls.updateUser(userId));
      var request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = 'Bearer ${AuthController.accessToken ?? ""}'; // Ensure auth if needed

      // Add form fields
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['gender'] = gender;
      request.fields['age'] = age.toString();
      request.fields['height'] = height.toString();
      request.fields['weight'] = weight.toString();

      // Add image if provided
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath('image', profileImage.path));
      }

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile: ${response.body}',
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }
}
