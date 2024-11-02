import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/views/home/profile/setting/change%20password/change_reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utlis/app-strings.dart';
import '../../../../../utlis/custom_text_style.dart';

class ChangeOtpVerificationScreen extends StatefulWidget {
  const ChangeOtpVerificationScreen({super.key});

  @override
  State<ChangeOtpVerificationScreen> createState() =>
      _ChangeOtpVerificationScreenState();
}

class _ChangeOtpVerificationScreenState
    extends State<ChangeOtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          title: HeadingTwo(data: AppString.otpVerifyEmail),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeH * .016),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(sizeH * .016),
                  child: Column(
                    children: [
                      const AppLogo(),
                      //==========================>Otp Field<============================

                      _buildPinCodeTextField(context),

                      SizedBox(
                        height: sizeH * .016,
                      ),
                      //==========================>Resend Button<============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingThree(data: AppString.otpDidNtGetCode),
                          StyleTextButton(
                              text: AppString.otpResend, onTap: () {}),
                        ],
                      ),
                      SizedBox(
                        height: sizeH * .02,
                      ),
                      //==========================>Otp Button<============================
                      CustomTextButton(
                          text: AppString.otpVerifyButton,
                          onTap: () {
                            Get.to(const ChangeResetPassScreen());
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

//pin code field

  PinCodeTextField _buildPinCodeTextField(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return PinCodeTextField(
      textStyle: const TextStyle(color: Colors.black),
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        fieldHeight: sizeH * .06,
        fieldWidth: sizeW * .11,
        activeFillColor: Colors.white,
        activeColor: Colors.white,
        selectedFillColor: Colors.white,
        selectedColor: Colors.white,
        inactiveFillColor: Colors.white,
        inactiveColor: Colors.white,
        errorBorderColor: Colors.red,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _otpTEController.dispose();
  }
}
