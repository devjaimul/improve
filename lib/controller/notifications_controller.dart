import 'package:get/get.dart';
import 'package:Improve.Ai/network%20caller/network_caller.dart';
import 'package:Improve.Ai/utlis/urls.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = <Map<String, dynamic>>[].obs; // Observable list for notifications

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(); // Fetch notifications when initialized
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;

    final response = await NetWorkCaller.getRequest(Urls.notifications);
    isLoading.value = false;

    if (response.isSuccess) {
      notifications.value = (response.responseData['data'] as List<dynamic>).map((notification) {
        return {
          'id': notification['id'],
          'message': notification['message'] ?? 'No Message',
          'isRead': notification['isRead'] ?? true, // Ensure a default value
          'createdAt': DateTime.tryParse(notification['createdAt']) ?? DateTime.now(),
        };
      }).toList();
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Failed to fetch notifications');
    }
  }
}
