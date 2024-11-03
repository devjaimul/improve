import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/custom_text_style.dart';
import 'package:Improve.Ai/controller/notifications_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    final notificationController = Get.put(NotificationController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Notification'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (notificationController.notifications.isEmpty) {
          return const Center(child: HeadingThree(data: "No Notifications Available!!"));
        }

        return ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final notification = notificationController.notifications[index];
            final isRead = notification['isRead'] as bool;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0 || !_isSameDay(notificationController.notifications[index - 1]['createdAt'], notification['createdAt']))
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: sizeH * .01),
                      child: HeadingThree(data: _formatDate(notification['createdAt'])),
                    ),
                  Card(
                    color: !isRead==true ? Colors.black.withOpacity(0.2) : Colors.transparent, // Adjusted for unseen logic
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.notifications_none,
                          size: sizeH * .03,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: const HeadingThree(data: 'Notification'),
                      subtitle: HeadingThree(
                        data: notification['message'],
                        fontSize: sizeH * .016,
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
