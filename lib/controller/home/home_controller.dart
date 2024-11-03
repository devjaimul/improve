import 'package:get/get.dart';
import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/utlis/urls.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var planImages = <Map<String, dynamic>>[].obs; // Observable list to store plan images data

  @override
  void onInit() {
    super.onInit();
    fetchPlanImages(); // Fetch data when the controller is initialized
  }

  Future<void> fetchPlanImages() async {
    isLoading.value = true;

    final response = await NetWorkCaller.getRequest(Urls.planImages);

    isLoading.value = false;

    if (response.isSuccess) {
      try {
        // Check if response data is valid and convert it to a list
        List<dynamic> data = response.responseData['data'] ?? [];

        // Ensure each image entry is properly structured
        planImages.value = data.map((plan) {
          return {
            'type': plan['type'] ?? 'unknown',
            'image': plan['image'] != null ? '${Urls.imageBaseUrl}/${plan['image']}' : 'default_image_path', // Provide a fallback image path
            'slogan': plan['slogan'] ?? 'No slogan available'
          };
        }).toList();
      } catch (e) {
        Get.snackbar('Error', 'Data parsing error: ${e.toString()}');
      }
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Failed to fetch plan images');
    }
  }
}
