import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/profile/subscription/my_subscription_after_buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utlis/app-strings.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_images.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Subscription Packages'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:sizeW*.03 ),
          child: Column(

crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: const AssetImage(AppImages.dumbbell,),height: sizeH*.2,),
              SizedBox(height: sizeH*.02,),
              const HeadingTwo(data: 'You’re not subscribed to any plan'),
              SizedBox(height: sizeH*.02),
              const Center(child: HeadingThree(data: 'Please subscribe a plan to use all the features')),


              SizedBox(height: sizeH*.04),
              _buildPackageCard(AppString.subPlanSliver, AppString.subPlanSliverPrice, AppString.subPlanSliverDuration,
                  backgroundColor:  AppColors.buttonColor),
              SizedBox(height:sizeH*.02),
              _buildPackageCard(AppString.subPlanGold, AppString.subPlanGoldPrice,AppString.subPlanGoldDuration,
                  backgroundColor: const Color(0xFF30b41f)),
              SizedBox(height: sizeH*.02),
              _buildPackageCard(AppString.subPlanPlatinum, AppString.subPlanPlatinumPrice, AppString.subPlanPlatinumDuration,
                  backgroundColor: const Color(0xFFde3fdb)),
              SizedBox(height: sizeH*.04),
              CustomTextButton(text: 'Next', onTap: (){
                Get.to(MySubscriptionAfterBuy());
              })


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
      String title, String price, String duration, {Color? backgroundColor}) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return InkWell(

      //onTap: ()=>Get.to(CongratulationScreen()),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        padding: EdgeInsets.symmetric(vertical:sizeH*.013 ,horizontal: sizeW*.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: sizeW*.35,
              height: sizeH*.06,
              child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: sizeW*.02,vertical: sizeH*.005),
                      child: HeadingTwo(data: title,color: Colors.black,),
                    ),
                  )),
            ),
            Row(
              children: [
                HeadingTwo(data: price),
                HeadingTwo(data: duration,color: Colors.white.withOpacity(0.7),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
