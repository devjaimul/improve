import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/workout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global widget/custom_card.dart';
import '../../views/bottom%20navigationBar/custom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeH * .018),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingThree(data: AppString.homeWorkOutText),
              SizedBox(
                height: sizeH * .016,
              ),
              CustomCard(
                img: AppImages.workout,
                title: AppString.workoutText,
                buttonText: AppString.workoutButton,
                onTap: () {
                  final navBarState = Get.find<CustomNavbarState>();
                  navBarState.setCurrentIndex(1);

                  // Navigate to workout screen
                },
              ),
              SizedBox(
                height: sizeH * .016,
              ),
              HeadingThree(data: AppString.homeMealText),
              SizedBox(
                height: sizeH * .016,
              ),
              CustomCard(
                img: AppImages.meal,
                title: AppString.mealText,
                buttonText: AppString.mealButton,
                onTap: () {
                  final navBarState = Get.find<CustomNavbarState>();
                  navBarState.setCurrentIndex(2);
                },
              ),
              SizedBox(
                height: sizeH * .016,
              ),
              HeadingThree(data: AppString.homeSportsText),
              SizedBox(
                height: sizeH * .016,
              ),
              CustomCard(
                img: AppImages.sports,
                title: AppString.sportsText,
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
  }
}
