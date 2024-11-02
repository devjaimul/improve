import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/bottom%20navigationBar/custom_navbar.dart';
import 'package:Improve.Ai/views/home/profile/subscription/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySubscriptionAfterBuy extends StatelessWidget {
  const MySubscriptionAfterBuy({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'My Subscription'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeH*.016),
          child: Column(
            children: [
              SizedBox(height: sizeH*.02,),
              Image(image: const AssetImage(AppImages.package,),height: sizeH*.3,),
              SizedBox(height: sizeH*.02,),
              const HeadingTwo(data: 'You’re subscribed to the BASIC plan'),
              SizedBox(height: sizeH*.016,),
              const HeadingThree(data: 'Plan is active until 30th October, 2024'),
              SizedBox(height: sizeH*.25,),
              CustomTextButton(text: 'See Packages', onTap: (){
                Get.to(const PackageScreen());
              }),
              SizedBox(height: sizeH*.02,),
              CustomTextButton(text: 'Back to Home', onTap: (){
                Get.offAll(const CustomNavbar());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
