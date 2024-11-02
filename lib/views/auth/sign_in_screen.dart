import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Improve.Ai/controller/auth/sign_in_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: HeadingTwo(data: AppString.signIn),
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
                padding: EdgeInsets.symmetric(horizontal: sizeW * .04),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppString.globalEmail,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: sizeH * .016),
                    TextFormField(
                      obscureText: true,
                      controller: _passTEController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppString.globalPass,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(
                      height: sizeH * .002,
                    ),
                    //==========================>Forget Button<============================
                    Align(
                        alignment: Alignment.centerRight,
                        child: StyleTextButton(
                            text: AppString.signInForgetPass,
                            onTap: () {
                              Get.offAllNamed(RouteNames.forgetPassScreen,);
                            })),

                    SizedBox(height: sizeH * .016),
                    Obx(() {
                      return CustomTextButton(
                        text: _signInController.isLoading.value ? 'Logging in...' : AppString.signInLogin,
                        onTap: () {
                          _signInController.signIn(
                            _emailTEController.text.trim(),
                            _passTEController.text.trim(),
                          );
                        },
                      );
                    }),
                    SizedBox(height: sizeH * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeadingThree(data: AppString.signInDoNtHaveAccount),
                        StyleTextButton(
                          text: AppString.signUp,
                          onTap: () => Get.offAllNamed(RouteNames.singUpScreen),
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
    _emailTEController.dispose();
    _passTEController.dispose();
    super.dispose();
  }
}
