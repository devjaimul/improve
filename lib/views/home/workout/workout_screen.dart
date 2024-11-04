import 'package:Improve.Ai/controller/home/home_controller.dart';
import 'package:Improve.Ai/controller/home/workout/workout_plan_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/global%20widget/custom_card.dart';
import 'package:Improve.Ai/utlis/app_colors.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/workout/workout_routine_screen.dart';
import 'package:Improve.Ai/views/home/workout/workout_view_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app-strings.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final WorkOutPlanController workOutPlanController = Get.find<WorkOutPlanController>(); // Find the instance
    final homeController = Get.find<HomeController>(); // Use Get to find the existing instance
// Get the Workout plan data
    final workOutPlan = homeController.planImages.firstWhere(
          (plan) => plan['type'] == 'workout',
      orElse: () => {'image': 'default_image_path', 'slogan': AppString.workoutText},
    );
    return Scaffold(
      body: Obx(() {
        if (workOutPlanController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check the status code to determine if the plan exists
        if (workOutPlanController.statusCode.value == 400 || workOutPlanController.workoutPlan.isEmpty) {

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(sizeH * .018),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingThree(data: AppString.homeWorkOutText),
                  SizedBox(height: sizeH * .016),
                  CustomCard(
                    img: workOutPlan['image'], // Fallback image
                    title: workOutPlan['slogan'],
                    buttonText: 'Make Your Plan',
                    onTap: () {
                      Get.to(const WorkoutRoutineScreen());
                    },
                    bgColor: AppColors.buttonSecondColor,
                  ),
                  SizedBox(height: sizeH * .016),
                  const HeadingThree(data: 'Your Workout Plan'),
                  SizedBox(height: sizeH * .018),
                  const HeadingTwo(data: 'Currently You Don’t Have any Workout Plan'),
                  SizedBox(height: sizeH * .02),
                  CustomButton(
                    text: 'Create your plan first',
                    onTap: () {
                      Get.to(const WorkoutRoutineScreen());
                    },
                  ),
                ],
              ),
            ),
          );
        }

        if (workOutPlanController.statusCode.value == 200 && workOutPlanController.workoutPlan.isNotEmpty) {

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(sizeH * .016),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingThree(data: AppString.homeWorkOutText),
                  SizedBox(height: sizeH * .016),
                  CustomCard(
                    img: workOutPlan['image'], // Fallback image
                    title: workOutPlan['slogan'],
                    buttonText: 'View Workout Plan',
                    onTap: () {
                      Get.to( const WorkoutViewPlanScreen());
                    },
                    bgColor: AppColors.buttonSecondColor,
                  ),
                  SizedBox(height: sizeH * .03),
                  CustomButton(
                    text: 'Generate New Routine',
                    onTap: () {
                      Get.to(const WorkoutRoutineScreen());
                    },
                  ),
                ],
              ),
            ),
          );
        }

        // Default case if no data
        return const Center(child: Text("No data available"));
      }),
    );
  }
}
