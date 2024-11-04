import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Improve.Ai/controller/home/workout/workout_plan_controller.dart';
import '../../../utlis/app_colors.dart';

class WorkoutViewPlanScreen extends StatelessWidget {
  const WorkoutViewPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final WorkOutPlanController workOutPlanController = Get.find<WorkOutPlanController>();

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Workout Plan'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (workOutPlanController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (workOutPlanController.workoutPlan.isEmpty) {
          return Center(
            child: HeadingThree(data: 'No workout plan available'),
          );
        }

        // Extract workout content from the controller
        final String workoutContent = workOutPlanController.workoutPlan['content'] ?? 'No content available';

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeH * .016),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(sizeH * .016),
                  child: SingleChildScrollView(
                    child: HeadingThree(data: workoutContent),
                  ),
                ),
                SizedBox(height: sizeH * .016),
                CustomTextButton(
                  text: 'Back to home',
                  onTap: () {
                    Get.offAllNamed(RouteNames.navBar);
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
