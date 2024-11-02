import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:Improve.Ai/views/home/profile/setting/change%20password/change_otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utlis/app-strings.dart';
import '../../../../../utlis/custom_text_style.dart';



class ChangeForgetPassScreen extends StatefulWidget {
  const ChangeForgetPassScreen({super.key});

  @override
  State<ChangeForgetPassScreen> createState() => _ChangeForgetPassScreenState();
}

class _ChangeForgetPassScreenState extends State<ChangeForgetPassScreen> {
  final TextEditingController _emailTEController = TextEditingController();

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
                            prefixIcon: AppIcons.email),
                      ),
                      SizedBox(
                        height: sizeH * .03,
                      ),

                      //==========================>Otp Button<============================

                      CustomTextButton(
                          text: AppString.forgetPassButton,
                          onTap: () {
                           Get.to(const ChangeOtpVerificationScreen());
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
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
}
