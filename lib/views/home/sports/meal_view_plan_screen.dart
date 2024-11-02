import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/global%20widget/custom_text.dart';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_colors.dart';

class SportsViewPlanScreen extends StatelessWidget {
  const SportsViewPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Sports View Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeH*.016),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: sizeH*.75,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:  EdgeInsets.all(sizeH*.016),
                child: const SingleChildScrollView(
                    child: CustomText()),
              ),
              SizedBox(height: sizeH*.016,),
              CustomTextButton(text: 'Back to home', onTap: (){Get.offAllNamed(RouteNames.navBar);})
            ],
          ),
        ),
      ),
    );
  }
}
