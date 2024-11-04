import 'package:Improve.Ai/controller/profile/policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/app-strings.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/custom_text_style.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final PolicyController policyController = Get.put(PolicyController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: HeadingTwo(data: AppString.settingPrivacy)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeH * .016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingThree(data: 'Our Policy'),
              SizedBox(height: sizeH * .02),
              Obx(() {
                if (policyController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  width: double.infinity,
                  height: sizeH * .77,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(sizeH * .016),
                  child: SingleChildScrollView(
                    child: HeadingThree(
                      data: policyController.privacy.value,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
