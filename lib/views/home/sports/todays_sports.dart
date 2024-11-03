import 'package:Improve.Ai/controller/home/home_controller.dart';
import 'package:Improve.Ai/views/home/sports/meal_view_plan_screen.dart';
import 'package:Improve.Ai/views/home/sports/sports_routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global widget/custom_button.dart';
import '../../../global widget/custom_card.dart';
import '../../../utlis/app-strings.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/custom_text_style.dart';

class TodaysSports extends StatelessWidget {
  const TodaysSports({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final homeController = Get.find<HomeController>(); // Use Get to find the existing instance

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Todays Sports Plan'),
        centerTitle: true,
      ),
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
            padding: EdgeInsets.all(sizeH * .016),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingThree(data: AppString.homeSportsText),
                SizedBox(height: sizeH * .016),
                CustomCard(
                  img: sportsPlan['image'],
                  title: sportsPlan['slogan'],
                  buttonText: 'View Sports Plan',
                  onTap: () {
                    Get.to(const SportsViewPlanScreen());
                  },
                  bgColor: AppColors.buttonSecondColor,
                ),
                SizedBox(height: sizeH * .03),
                CustomButton(
                  text: 'Generate New Routine',
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
