import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/profile/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utlis/app-strings.dart';



class ChangeResetPassScreen extends StatefulWidget {
  const ChangeResetPassScreen({super.key});

  @override
  State<ChangeResetPassScreen> createState() => _ChangeResetPassScreenState();
}

class _ChangeResetPassScreenState extends State<ChangeResetPassScreen> {
  final TextEditingController _rePassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          title: HeadingTwo(data: AppString.resetButton),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeH * .016),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                Padding(
                  padding: EdgeInsets.all(sizeH * .016),
                  child: Column(
                    children: [
                      //==========================>Text Field<============================
                      TextFormField(
                        controller: _passTEController,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppString.resetNewsPass,
                          prefixIcon: AppIcons.key,
                          suffixIcon: AppIcons.visibility,
                        ),
                      ),
                      SizedBox(
                        height: sizeH * .016,
                      ),
                      TextFormField(
                        controller: _rePassTEController,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppString.resetRePass,
                          prefixIcon: AppIcons.key,
                          suffixIcon: AppIcons.visibility,
                        ),
                      ),
                      SizedBox(
                        height: sizeH * .02,
                      ),
                      //==========================>Reset Pass Button<============================
                      CustomTextButton(
                          text: AppString.resetButton,
                          onTap: () {
                            // Avoid potential issues with disposed controllers
                            if (mounted) {
                              Get.to(const SettingScreen());
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _passTEController.dispose();
    _rePassTEController.dispose();
    super.dispose(); // Call after controllers are disposed
  }
}

