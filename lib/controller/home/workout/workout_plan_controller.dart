import 'package:get/get.dart';
import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/utlis/urls.dart';

class WorkOutPlanController extends GetxController {
  var isLoading = false.obs;
  var workoutPlan = {}.obs; // Observable map to store workout plan data
  var statusCode = 0.obs; // Observable to store the API status code

  @override
  void onInit() {
    super.onInit();
    fetchWorkoutPlan(); // Fetch data when the controller is initialized
  }

  Future<void> fetchWorkoutPlan() async {
    isLoading.value = true;

    final response = await NetWorkCaller.getRequest(Urls.workout);

    isLoading.value = false;
    statusCode.value = response.statusCode ?? 0; // Store the API status code

    if (response.isSuccess) {
      workoutPlan.value = response.responseData['data'] ?? {};
    } else {
      workoutPlan.clear();
      Get.snackbar('Error', response.errorMessage ?? 'Failed to fetch workout plan');
    }
  }
}

