import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'dart:io';
import 'package:Improve.Ai/global%20widget/custom_button.dart'; // Custom button import
import 'package:Improve.Ai/utlis/app_images.dart';

import '../../../utlis/custom_text_style.dart'; // App images import

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  // TextEditingControllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();
  File? _profileImage; // To store the selected profile image

  // Show dialog to pick image source
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path); // Set the picked image
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path); // Set the captured image
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.15;
    final double textFontSize = size.width * 0.04;
    final double fieldHeight = size.height * 0.07;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const HeadingTwo(data: 'Profile Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),

              // Profile Picture with Edit Icon
              Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) // Show the selected image
                        : const AssetImage(AppImages.profile) as ImageProvider, // Placeholder image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage, // Trigger image picker dialog
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: avatarRadius * 0.25,
                        child: Icon(
                          Icons.camera_alt,
                          size: avatarRadius * 0.25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              // Profile Form Fields
              _buildProfileTextField('Your Name', nameController, fieldHeight, textFontSize),
              _buildProfileTextField('E-mail', emailController, fieldHeight, textFontSize),
              _buildProfileTextField('Address', addressController, fieldHeight, textFontSize),
              _buildProfileTextField('Gender', genderController, fieldHeight, textFontSize),
              _buildProfileTextField('Age', ageController, fieldHeight, textFontSize),
              _buildProfileTextField('Height', heightController, fieldHeight, textFontSize),
              _buildProfileTextField('Weight', weightController, fieldHeight, textFontSize),

              SizedBox(height: size.height * 0.03),

              // Update Profile Button
              CustomTextButton(
                text: 'Update Profile',
                onTap: () {
                  Get.back();
                  Get.back();
                  // Handle the profile update API integration here
                  // Pass this profileData and the selected image (_profileImage) to your API request
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build text fields for profile information
  Widget _buildProfileTextField(String label, TextEditingController controller, double height, double textFontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height,
        child: TextField(
          controller: controller..text, // Setting initial value
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          style: TextStyle(fontSize: textFontSize, color: Colors.white),
        ),
      ),
    );
  }
}
