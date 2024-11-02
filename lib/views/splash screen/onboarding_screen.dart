import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/app_colors.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_name.dart';
import '../../utlis/app_images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //main image
          Image.asset(
            AppImages.splashScreen,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
          ),
          //dark shadow
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          //main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW * .12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //app logo
                  Image.asset(
                    AppImages.logoWhite,
                    height: sizeH * .3,
                    width: sizeW * .7,
                  ),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                  //title
                  HeadingTwo(
                    data: 'Your Health Journey \n Starts with Experts',
                    fontSize: sizeH * .030,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                  //subtitle
                  HeadingThree(
                    data: AppString.splashText2,
                    fontSize: sizeH * .018,
                  ),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                  //button
                  CustomTextButton(
                    text: AppString.splashButtonText,
                    onTap: () {
                      Get.offAllNamed(RouteNames.singUpScreen);
                    },
                  ),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                  //already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeadingThree(
                        data: AppString.alreadyAccount,
                        fontSize: sizeH * .018,
                      ),
                      StyleTextButton(
                        text: AppString.signIn,
                        onTap: () {
                          Get.offAllNamed(RouteNames.signInScreen);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
