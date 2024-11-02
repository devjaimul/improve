import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:Improve.Ai/views/home/profile/profile_update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.15;
    final double textFontSize = size.width * 0.04;
    final double fieldHeight = size.height * 0.07;

    return Scaffold(
      appBar: AppBar(
   
        centerTitle: true,
        title:HeadingTwo(data: 'Profile Information') ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              // Profile Picture
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage:  AssetImage(AppImages.profile), // Replace with your image
              ),
              SizedBox(height: size.height * 0.03),

              // Profile Form Fields
              _buildProfileTextField('Your Name', 'Victor', fieldHeight, textFontSize),
              _buildProfileTextField('E-mail', 'victorthegymbro@gmail.com', fieldHeight, textFontSize),
              _buildProfileTextField('Address', '32/A village/area, city-342', fieldHeight, textFontSize),
              _buildProfileTextField('Gender', 'Male', fieldHeight, textFontSize),
              _buildProfileTextField('Age', '24 year', fieldHeight, textFontSize),
              _buildProfileTextField('Height', '178 cm', fieldHeight, textFontSize),
              _buildProfileTextField('Weight', '55 kg', fieldHeight, textFontSize),

              SizedBox(height: size.height * 0.03),

              // Edit Profile Button
         CustomTextButton(text: 'Edit Profile', onTap: (){Get.to(ProfileUpdate());})
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build text fields for profile information
  Widget _buildProfileTextField(String label, String value, double height, double textFontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
