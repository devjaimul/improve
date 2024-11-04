import 'package:Improve.Ai/controller/auth/reset_pass_controller.dart';
import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/auth/otp_verification_screen.dart';
import 'package:Improve.Ai/views/bottom%20navigationBar/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _oldPassTEController = TextEditingController();
  final TextEditingController _rePassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final ResetPassController _resetPassController = Get.put(ResetPassController());
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeH * .016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: sizeH * .2),
              TextFormField(
                controller: _oldPassTEController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Old Password',
                  prefixIcon: AppIcons.key,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: sizeH * .016),
              TextFormField(
                controller: _passTEController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: AppString.resetNewsPass,
                  prefixIcon: AppIcons.key,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: sizeH * .016),
              TextFormField(
                controller: _rePassTEController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: AppString.resetRePass,
                  prefixIcon: AppIcons.key,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: StyleTextButton(
                  text: 'Forget Password',
                  onTap: () {
                    String? userId = AuthController.getUserId();
                    if (userId != null && userId.isNotEmpty) {
                      debugPrint('Navigating to OtpVerificationScreen with userId: $userId');
                      Get.offAll(OtpVerificationScreen(userId: userId, isFromSignUp: false, cameFromChangePass: true));
                    } else {
                      debugPrint('User ID is missing before navigation.');
                      Get.snackbar('Error', 'User ID is missing');
                    }
                  },
                ),
              ),
              SizedBox(height: sizeH * .02),
              CustomTextButton(
                text: 'Change Password',
                onTap: () async {
                  // Validate if the new password and retype password match
                  if (_passTEController.text.trim() != _rePassTEController.text.trim()) {
                    Get.snackbar('Error', 'New password and Retype new password do not match');
                    return;
                  }

                  String? userId = AuthController.getUserId();
                  debugPrint('Retrieved user ID: $userId');

                  if (userId != null) {
                    debugPrint('Attempting to change password for user ID: $userId');
                    bool isSuccess = await _resetPassController.resetPassword(
                      userId,
                      _passTEController.text.trim(),
                      oldPassword: _oldPassTEController.text.trim(),
                    );
                    if (isSuccess) {
                      Get.offAll(const CustomNavbar());
                      debugPrint('Password changed successfully');
                    } else {
                      debugPrint('Password change failed');
                      Get.snackbar('Error', 'Failed to change password');
                    }
                  } else {
                    debugPrint('User ID is missing');
                    Get.snackbar('Error', 'User ID is missing');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPassTEController.dispose();
    _rePassTEController.dispose();
    _passTEController.dispose();
    super.dispose();
  }
}
