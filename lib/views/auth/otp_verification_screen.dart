import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controller/auth/otp_controller.dart';
import '../../utlis/app-strings.dart';
import '../../global widget/app_logo.dart';
import '../../global widget/custom_button.dart';
import '../../utlis/custom_text_style.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String userId;
  final bool isFromSignUp;
  final bool cameFromChangePass;

  const OtpVerificationScreen({super.key, required this.userId, this.isFromSignUp = false, this.cameFromChangePass = false});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final otpController = Get.put(OtpController());

  @override
  void initState() {
    super.initState();
    otpController.startCountdown();

    if (widget.userId.isNotEmpty) {
      debugPrint('Sending OTP for userId: ${widget.userId}');
      otpController.resendOtp(widget.userId);
    } else {
      debugPrint('User ID is missing. Cannot send OTP.');
      Get.snackbar('Error', 'User ID is missing');
    }
  }

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
                    _buildPinCodeTextField(context),
                    SizedBox(height: sizeH * .016),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingThree(data: AppString.otpDidNtGetCode),
                        Obx(() {
                          return otpController.isCountingDown
                              ? HeadingThree(data: "Resend in ${otpController.countdown}s")
                              : StyleTextButton(
                            text: otpController.isResending ? "Resending..." : AppString.otpResend,
                            onTap: () {
                              if (!otpController.isResending && !otpController.isCountingDown) {
                                otpController.resendOtp(widget.userId);
                              }
                            },
                          );
                        })
                      ],
                    ),
                    SizedBox(height: sizeH * .02),
                    CustomTextButton(
                      text: otpController.isLoading ? "Verifying..." : AppString.otpVerifyButton,
                      onTap: () {
                        if (!otpController.isLoading && _otpTEController.text.isNotEmpty) {
                          otpController.verifyOtp(_otpTEController.text, widget.userId, widget.isFromSignUp, cameFromChangePass: widget.cameFromChangePass);
                        } else {
                          Get.snackbar("Error", "Please enter the OTP");
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
}
