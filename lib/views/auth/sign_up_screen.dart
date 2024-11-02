import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth/sign_up_controller.dart';
import '../../routes/routes_name.dart';

import '../../utlis/app-strings.dart';
import '../../utlis/custom_text_style.dart';
import '../../global%20widget/app_logo.dart';
import '../../global%20widget/custom_button.dart';
import '../../utlis/app_icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final signUpController = Get.put(SignUpController());

  // State variables to track visibility of passwords
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: HeadingTwo(data: AppString.signUpAppBar),
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
                    // Name field
                    TextFormField(
                      controller: _nameTEController,
                      decoration: InputDecoration(
                        hintText: AppString.signUpName,
                        prefixIcon: AppIcons.profile,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .016),

                    // Email field
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppString.globalEmail,
                        prefixIcon: AppIcons.email,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .016),

                    // Password field with toggle visibility icon
                    TextFormField(
                      controller: _passTEController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: AppString.globalPass,
                        prefixIcon: AppIcons.key,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .016),

                    // Confirm Password field with toggle visibility icon
                    TextFormField(
                      controller: _confirmPassTEController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: AppString.singUpConformPass,
                        prefixIcon: AppIcons.key,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: sizeH * .02),

                    // Register button
                    Obx(() {
                      return CustomTextButton(
                        text: signUpController.isLoading
                            ? "Registering..."
                            : AppString.signUp,
                        onTap: () {
                          if (!signUpController.isLoading) {
                            signUpController.registerUser(
                              email: _emailTEController.text,
                              password: _passTEController.text,
                              confirmPassword: _confirmPassTEController.text,
                              name: _nameTEController.text,
                            );
                          }
                        },
                      );
                    }),

                    SizedBox(height: sizeH * .016),

                    // Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeadingThree(data: AppString.alreadyAccount),
                        StyleTextButton(
                          text: AppString.signIn,
                          onTap: () {
                            Get.offAllNamed(RouteNames.signInScreen);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _nameTEController.dispose();
    _confirmPassTEController.dispose();
    _passTEController.dispose();
  }
}
