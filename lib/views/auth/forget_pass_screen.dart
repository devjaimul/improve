import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth/forget_pass_controller.dart';
import '../../utlis/app-strings.dart';
import '../../utlis/custom_text_style.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final ForgetPassController _forgetPassController = Get.put(ForgetPassController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          title: HeadingTwo(data: AppString.forgetPass),
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
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppString.globalEmail,
                          prefixIcon: AppIcons.email,
                        ),
                      ),
                      SizedBox(height: sizeH * .03),
                      //==========================>Otp Button<============================
                      Obx(() {
                        return CustomTextButton(
                          text: _forgetPassController.isLoading.value
                              ? "Sending..."
                              : AppString.forgetPassButton,
                          onTap: () {
                            if (_emailTEController.text.isNotEmpty) {
                              _forgetPassController.sendForgetPasswordRequest(
                                  _emailTEController.text);
                            } else {
                              Get.snackbar("Error", "Please enter your email.");
                            }
                          },
                        );
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
    super.dispose();
    _emailTEController.dispose();
  }
}
