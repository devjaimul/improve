import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/global%20widget/custom_text.dart';
import 'package:Improve.Ai/utlis/app_colors.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/meal/todays_meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealGenerateScreen extends StatelessWidget {
  const MealGenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Generate Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeH*.018),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: sizeH*.67,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:  EdgeInsets.all(sizeH*.016),
                child: const SingleChildScrollView(
                  //this custom text create to design the generate the text field
                    child: CustomText()),
              ),
               SizedBox(height: sizeH*.018),
               Column(
              children: [
                CustomTextButton(text: 'Confirm Generate', onTap: (){
                  Get.to(const TodaysMeal());
                }),
                SizedBox(height: sizeH*.018),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Expanded(child: CustomButton(text: 'Easier', onTap: (){})),
                  SizedBox(width: sizeW*.03,),
                  Expanded(child: CustomButton(text: 'Harder', onTap: (){})),
                ],)
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}

