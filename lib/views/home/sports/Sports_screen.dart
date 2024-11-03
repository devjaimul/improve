import 'package:Improve.Ai/controller/home/home_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/global%20widget/custom_card.dart';
import 'package:Improve.Ai/utlis/app_colors.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/sports/sports_routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app-strings.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final homeController = Get.find<HomeController>(); // Use Get to find the existing instance

    return Scaffold(
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homeController.planImages.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        // Get the sports plan data
        final sportsPlan = homeController.planImages.firstWhere(
              (plan) => plan['type'] == 'sport',
          orElse: () => {'image': 'default_image_path', 'slogan': AppString.sportsText},
        );

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeH * .018),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingThree(data: AppString.homeSportsText),
                SizedBox(height: sizeH * .016),
                CustomCard(
                  img: sportsPlan['image'],
                  title: sportsPlan['slogan'],
                  buttonText: 'Make Your Plan',
                  onTap: () {
                    Get.to(const SportsRoutineScreen());
                  },
                  bgColor: AppColors.buttonSecondColor,
                ),
                SizedBox(height: sizeH * .016),
                const HeadingThree(data: 'Your Sports Plan'),
                SizedBox(height: sizeH * .018),
                const HeadingTwo(data: 'Currently You Don’t Have any Sports Plan'),
                SizedBox(height: sizeH * .02),
                CustomButton(
                  text: 'Create your plan first',
                  onTap: () {
                    Get.to(const SportsRoutineScreen());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
