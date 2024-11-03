import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/utlis/urls.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = {}.obs; // Observable to hold profile information

  @override
  void onInit() {
    super.onInit();
    fetchProfileInfo();
  }

  Future<void> fetchProfileInfo() async {
    isLoading.value = true;

    final response = await NetWorkCaller.getRequest(Urls.profileInfo);
    isLoading.value = false;

    if (response.isSuccess) {
      profileData.value = response.responseData['data'] ?? {};
      // Debug the image URL
      debugPrint('Profile image URL: ${profileData['image']}');
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Failed to load profile information');
    }

  }
}
