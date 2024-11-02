import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/reset_pass_controller.dart';
import '../../global%20widget/app_logo.dart';
import '../../global%20widget/custom_button.dart';
import '../../utlis/app_icons.dart';
import '../../utlis/custom_text_style.dart';
import '../../utlis/app-strings.dart';

class ResetPassScreen extends StatefulWidget {
  final String userId;

  const ResetPassScreen({super.key, required this.userId});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController _rePassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final ResetPassController _resetPassController = Get.put(ResetPassController());

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
                    TextFormField(
                      obscureText: true,
                      controller: _passTEController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppString.resetNewsPass,
                        prefixIcon: AppIcons.key,
                        suffixIcon: AppIcons.visibility,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .016),
                    TextFormField(
                      obscureText: true,
                      controller: _rePassTEController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppString.resetRePass,
                        prefixIcon: AppIcons.key,
                        suffixIcon: AppIcons.visibility,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .02),
                    Obx(() {
                      return CustomTextButton(
                        text: _resetPassController.isLoading.value ? 'Resetting...' : AppString.resetButton,
                        onTap: () {
                          if (_passTEController.text == _rePassTEController.text) {
                            _resetPassController.resetPassword(
                              widget.userId,
                              _passTEController.text.trim(),
                            );
                          } else {
                            Get.snackbar('Error', 'Passwords do not match');
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
