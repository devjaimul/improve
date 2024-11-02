import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/profile/subscription/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySubscriptionBeforePay extends StatelessWidget {
  const MySubscriptionBeforePay({super.key});

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
               Image(image: AssetImage(AppImages.dumbbell,),height: sizeH*.3,),
              SizedBox(height: sizeH*.02,),
              const HeadingTwo(data: 'You’re not subscribed to any plan'),
              SizedBox(height: sizeH*.016,),
              const HeadingThree(data: 'Please subscribe a plan to use all the features'),
              SizedBox(height: sizeH*.3,),
              CustomTextButton(text: 'See Packages', onTap: (){
                Get.to(PackageScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
