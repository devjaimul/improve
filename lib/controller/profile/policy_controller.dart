import 'package:get/get.dart';
import '../../network caller/network_caller.dart';
import '../../utlis/urls.dart';

class PolicyController extends GetxController {
  var about = ''.obs;
  var privacy = ''.obs;
  var terms = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPolicies();
  }

  Future<void> fetchPolicies() async {
    isLoading.value = true;
    final response = await NetWorkCaller.getRequest(Urls.policy);

    if (response.isSuccess) {
      about.value = response.responseData['data']['about'] ?? 'No data available';
      privacy.value = response.responseData['data']['privacy'] ?? 'No data available';
      terms.value = response.responseData['data']['terms'] ?? 'No data available';
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Failed to fetch policies');
    }
    isLoading.value = false;
  }
}
