import 'package:Improve.Ai/controller/auth/reset_pass_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/bottom%20navigationBar/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_name.dart';

class ResetPassScreen extends StatefulWidget {
  final String userId;
  final bool cameFromChangePass;

  const ResetPassScreen({super.key, required this.userId, this.cameFromChangePass = false});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController _rePassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final ResetPassController _resetPassController = Get.put(ResetPassController());
  bool _isPasswordVisible = false;

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
              SizedBox(height: sizeH * .2),
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
              SizedBox(height: sizeH * .02),
              Obx(() {
                return CustomTextButton(
                  text: _resetPassController.isLoading.value ? 'Resetting...' : AppString.resetButton,
                  onTap: () async {
                    // Validate if the new password and retype password match
                    if (_passTEController.text.trim() != _rePassTEController.text.trim()) {
                      Get.snackbar('Error', 'New password and Retype new password do not match');
                      return;
                    }

                    bool isSuccess = await _resetPassController.resetPassword(
                      widget.userId,
                      _passTEController.text.trim(),
                    );

                    if (isSuccess) {
                      if (widget.cameFromChangePass) {
                        debugPrint('Navigating to CustomNavbar from ResetPassScreen');
                        Get.offAll(() => CustomNavbar()); // Navigate to CustomNavbar
                      } else {
                        debugPrint('Navigating to sign-in screen from ResetPassScreen');
                        Get.offAllNamed(RouteNames.signInScreen); // Navigate to the sign-in screen
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passTEController.dispose();
    _rePassTEController.dispose();
    super.dispose();
  }
}
