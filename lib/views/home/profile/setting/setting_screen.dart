import 'package:Improve.Ai/views/home/profile/setting/about_screen.dart';
import 'package:Improve.Ai/views/home/profile/setting/change%20password/change_password.dart';
import 'package:Improve.Ai/views/home/profile/setting/privacy_policy_screen.dart';
import 'package:Improve.Ai/views/home/profile/setting/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




import '../../../../utlis/custom_text_style.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: const HeadingTwo(data: 'Setting'),),
      body: Padding(
        padding:  EdgeInsets.all(sizeH*.008),
        child: Column(
          children: [
            _buildProfileOption(
              icon: Icons.lock,
              label: 'Change Password',
              onTap: () {
                Get.to(ChangePassScreen());
              },
            ),
            _buildProfileOption(
              icon: Icons.privacy_tip,
              label: 'Privacy Policy',
              onTap: () {
                Get.to(PrivacyPolicyScreen());
              },
            ),
            _buildProfileOption(
              icon: Icons.info_outline,
              label: 'Terms of Services',
              onTap: () {
                Get.to(TermsScreen());
              },
            ),
            _buildProfileOption(
              icon: Icons.help_outline,
              label: 'About Us',
              onTap: () {
                Get.to(AboutScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
  // Helper widget to build the profile options
  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    Color borderColor = Colors.white24,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Icon(icon, color: iconColor, size: 20.h),
              SizedBox(width: 20.w),
              Expanded(child: HeadingThree(data: label)),

              Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 18.h),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
