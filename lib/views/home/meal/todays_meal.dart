import 'package:Improve.Ai/views/home/meal/meal_routine_screen.dart';
import 'package:Improve.Ai/views/home/meal/meal_view_plan_screen.dart';
import 'package:Improve.Ai/views/home/workout/workout_routine_screen.dart';
import 'package:Improve.Ai/views/home/workout/workout_view_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global widget/custom_button.dart';
import '../../../global widget/custom_card.dart';
import '../../../utlis/app-strings.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/app_images.dart';
import '../../../utlis/custom_text_style.dart';

class TodaysMeal extends StatelessWidget {
  const TodaysMeal({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Todays Meal Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeH * .016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingThree(data: AppString.homeMealText),
              SizedBox(
                height: sizeH * .016,
              ),
              CustomCard(
                img: AppImages.meal,
                title: AppString.mealText,
                buttonText: 'View Meal Plan',
                onTap: () {
                  Get.to(const MealViewPlanScreen());
                },
                bgColor: AppColors.buttonSecondColor,
              ),
              SizedBox(
                height: sizeH * .03,
              ),
              CustomButton(
                  text: 'Generate New Routine',
                  onTap: () {
                    Get.to(const MealRoutineScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
