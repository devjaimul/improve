import 'package:Improve.Ai/controller/home/home_controller.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global widget/custom_card.dart';
import '../../utlis/app_images.dart';
import '../../views/bottom%20navigationBar/custom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final homeController = Get.put(HomeController());  // Initialize the HomeController

    Future<void> _refreshData() async {
      // Call the method to refresh data from the API
      await homeController.fetchPlanImages();
    }

    return Scaffold(
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homeController.planImages.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        // Extract plan data for each section
        final workoutPlan = homeController.planImages.firstWhere(
              (plan) => plan['type'] == 'workout',
          orElse: () => {'image': AppImages.workout, 'slogan': AppString.workoutText},
        );
        final mealPlan = homeController.planImages.firstWhere(
              (plan) => plan['type'] == 'meal',
          orElse: () => {'image': AppImages.meal, 'slogan': AppString.mealText},
        );
        final sportPlan = homeController.planImages.firstWhere(
              (plan) => plan['type'] == 'sport',
          orElse: () => {'image': AppImages.sports, 'slogan': AppString.sportsText},
        );

        return RefreshIndicator(
          onRefresh: _refreshData,  // Trigger refresh when pulled
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // Ensure scroll even when content is small
            child: Padding(
              padding: EdgeInsets.all(sizeH * .018),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingThree(data: AppString.homeWorkOutText),
                  SizedBox(height: sizeH * .016),
                  CustomCard(
                    img: workoutPlan['image'],
                    title: workoutPlan['slogan'],
                    buttonText: AppString.workoutButton,
                    onTap: () {
                      final navBarState = Get.find<CustomNavbarState>();
                      navBarState.setCurrentIndex(1);
                    },
                  ),
                  SizedBox(height: sizeH * .016),
                  HeadingThree(data: AppString.homeMealText),
                  SizedBox(height: sizeH * .016),
                  CustomCard(
                    img: mealPlan['image'],
                    title: mealPlan['slogan'],
                    buttonText: AppString.mealButton,
                    onTap: () {
                      final navBarState = Get.find<CustomNavbarState>();
                      navBarState.setCurrentIndex(2);
                    },
                  ),
                  SizedBox(height: sizeH * .016),
                  HeadingThree(data: AppString.homeSportsText),
                  SizedBox(height: sizeH * .016),
                  CustomCard(
                    img: sportPlan['image'],
                    title: sportPlan['slogan'],
                    buttonText: AppString.sportsButton,
                    onTap: () {
                      final navBarState = Get.find<CustomNavbarState>();
                      navBarState.setCurrentIndex(3);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
