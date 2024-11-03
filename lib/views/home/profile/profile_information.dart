import 'package:Improve.Ai/controller/profile/profile_controller.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:Improve.Ai/views/home/profile/profile_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.15;
    final double textFontSize = size.width * 0.04;
    final double fieldHeight = size.height * 0.07;

    final profileController = Get.put(ProfileController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const HeadingTwo(data: 'Profile Information'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = profileController.profileData;

        return profile.isEmpty
            ? const Center(child: Text('No profile data available'))
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),
                // Profile Picture
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: (profile['image'] != null && profile['image'].isNotEmpty)
                      ?NetworkImage('${Urls.imageBaseUrl}/${profile['image']}')
                      : const AssetImage(AppImages.profile) as ImageProvider,
                  onBackgroundImageError: (_, __) {
                    debugPrint('Failed to load network image.');
                  },
                ),

                SizedBox(height: size.height * 0.03),

                // Profile Form Fields
                _buildProfileTextField('Your Name', profile['name'] ?? 'N/A', fieldHeight, textFontSize),
                _buildProfileTextField('E-mail', profile['email'] ?? 'N/A', fieldHeight, textFontSize),
                _buildProfileTextField('Address', profile['address'] ?? 'N/A', fieldHeight, textFontSize),
                _buildProfileTextField('Gender', profile['gender'] ?? 'N/A', fieldHeight, textFontSize),
                _buildProfileTextField('Age', '${profile['age'] ?? 'N/A'} year', fieldHeight, textFontSize),
                _buildProfileTextField('Height', '${profile['height'] ?? 'N/A'} cm', fieldHeight, textFontSize),
                _buildProfileTextField('Weight', '${profile['weight'] ?? 'N/A'} kg', fieldHeight, textFontSize),

                SizedBox(height: size.height * 0.03),

                // Edit Profile Button
                CustomTextButton(
                  text: 'Edit Profile',
                  onTap: () async {
                    if (profile.isNotEmpty && profile['id'] != null) {
                      // Navigate to the ProfileUpdate screen and wait for the result
                      await Get.to(() => ProfileUpdate(userId: profile['id']));
                      // Refresh the profile data after returning
                      profileController.fetchProfileInfo();
                    } else {
                      Get.snackbar('Error', 'User ID is not available');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Helper widget to build text fields for profile information
  Widget _buildProfileTextField(String label, String value, double height, double textFontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        height: height,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white70),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white70),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          style: TextStyle(fontSize: textFontSize, color: Colors.white),
          controller: TextEditingController(text: value),
        ),
      ),
    );
  }
}

