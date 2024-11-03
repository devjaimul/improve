import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:Improve.Ai/controller/profile/profile_controller.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:Improve.Ai/views/home/profile/profile_information.dart';
import 'package:Improve.Ai/views/home/profile/setting/setting_screen.dart';
import 'package:Improve.Ai/views/home/profile/subscription/my_subscription_before_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/routes_name.dart';
import '../../../utlis/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    // Access the ProfileController to track user data
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return const CircularProgressIndicator(); // Display a loader while data is being fetched
          }

          final profile = profileController.profileData;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: sizeH * .05), // Spacing from top using screen height
              // Profile picture
              CircleAvatar(
                radius: sizeH * .06,
                backgroundImage: (profile['image'] != null && profile['image'].isNotEmpty)
                    ? NetworkImage('${Urls.imageBaseUrl}/${profile['image']}')
                    : const AssetImage(AppImages.profile) as ImageProvider,
                onBackgroundImageError: (_, __) {
                  debugPrint('Failed to load network image.');
                },
              ),
              SizedBox(height: sizeH * .02), // Spacing below the profile picture
              // Name
              HeadingTwo(data: profile['name'] ?? 'User Name'),

              SizedBox(height: sizeH * .016),
              const Divider(
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: sizeH * .02),
              // Profile buttons
              _buildProfileOption(
                icon: Icons.person_outline,
                label: 'Profile Information',
                onTap: () async {
                  await Get.to(const ProfileInformation());
                  // Refresh the profile data when returning from ProfileInformation
                  profileController.fetchProfileInfo();
                },
              ),
              _buildProfileOption(
                icon: Icons.subscriptions_outlined,
                label: 'Subscription',
                onTap: () {
                  Get.to(MySubscriptionBeforePay());
                },
              ),
              _buildProfileOption(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () {
                  Get.to(const SettingScreen());
                },
              ),
              SizedBox(height: sizeH * .02),
              // Logout button
              _buildProfileOption(
                isTrue: true,
                icon: Icons.logout,
                label: 'Logout',
                iconColor: Colors.red,
                labelColor: Colors.red,
                borderColor: Colors.red,
                onTap: () {
                  Get.bottomSheet(_buildLogoutBottomSheet(context));
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  // Helper widget to build the profile options
  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    Color labelColor = Colors.white,
    Color borderColor = Colors.white24,
    final bool? isTrue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
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
              isTrue == true
                  ? const Icon(null)
                  : Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.h),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }

  // Build the custom logout bottom sheet
  Widget _buildLogoutBottomSheet(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Container(
      height: sizeH * 0.3,
      padding: EdgeInsets.symmetric(vertical: sizeH * .02, horizontal: sizeW * .035),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeadingTwo(
            data: 'Are you sure you want to',
            color: Colors.white,
          ),
          const HeadingTwo(
            data: 'logout?',
            color: Colors.red,
          ),
          SizedBox(height: sizeH * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildCancelButton(context),
              ),
              SizedBox(width: sizeW * .03),
              Expanded(
                child: _buildLogoutButton(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget to build the Cancel button
  Widget _buildCancelButton(context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () {
        Get.back(); // Close the bottom sheet
      },
      child: Container(
        height: sizeH * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white),
          color: Colors.transparent,
        ),
        child: const Center(
          child: HeadingThree(data: 'Cancel'),
        ),
      ),
    );
  }

  // Helper widget to build the Logout button
  Widget _buildLogoutButton(context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () {
        AuthController.clearAllData();
        Get.offAllNamed(RouteNames.signInScreen); // Navigate to the sign-in screen
      },
      child: Container(
        height: sizeH * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.red,
          border: Border.all(color: Colors.white),
        ),
        child: const Center(
          child: HeadingThree(data: 'Logout'),
        ),
      ),
    );
  }
}
