import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_icons.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/profile/setting/change%20password/change_forget_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes_name.dart';
import '../../../../../utlis/app-strings.dart';


class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _oldPassTEController = TextEditingController();
  final TextEditingController _rePassTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          title: HeadingTwo(data: 'Change Password'),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //==========================>Text Field<============================
                      SizedBox(
                        height: sizeH * .2,
                      ),
                      TextFormField(
                        controller: _oldPassTEController,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Old Password',
                          prefixIcon: AppIcons.key,
                          suffixIcon: AppIcons.visibility,
                        ),
                      ),
                      SizedBox(
                        height: sizeH * .016,
                      ),
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
                      StyleTextButton(
                          text: 'Forget Password',
                          onTap: () {
                           Get.to(ChangeForgetPassScreen());
                          }),

                      SizedBox(
                        height: sizeH * .02,
                      ),
                      //==========================>Reset Pass Button<============================
                      CustomTextButton(
                          text: 'Change Password',
                          onTap: () {
                            Get.back();
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
    _passTEController.dispose();
    _rePassTEController.dispose();
    _oldPassTEController.dispose();
  }
}
