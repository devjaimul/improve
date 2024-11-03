import 'package:Improve.Ai/controller/profile/update_profile_controller.dart';
import 'package:Improve.Ai/controller/profile/profile_controller.dart';
import 'package:Improve.Ai/utlis/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app_images.dart';
import '../../../utlis/custom_text_style.dart';

class ProfileUpdate extends StatefulWidget {
  final String userId;
  const ProfileUpdate({super.key, required this.userId});

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final UpdateProfileController _updateProfileController = Get.put(UpdateProfileController());
  final ProfileController _profileController = Get.find<ProfileController>(); // Find the existing controller
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load existing profile data as initial values in the controllers
    if (_profileController.profileData.isNotEmpty) {
      final profile = _profileController.profileData;
      nameController.text = profile['name'] ?? '';
      addressController.text = profile['address'] ?? '';
      genderController.text = profile['gender'] ?? '';
      ageController.text = profile['age'] != null ? profile['age'].toString() : '';
      heightController.text = profile['height'] != null ? profile['height'].toString() : '';
      weightController.text = profile['weight'] != null ? profile['weight'].toString() : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const HeadingTwo(data: 'Profile Update'),
      ),
      body: Obx(() {
        if (_updateProfileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = _profileController.profileData;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: size.height * 0.08,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) // Display the local image if present
                          : (profile['image'] != null && profile['image'].isNotEmpty)
                          ? NetworkImage('${Urls.imageBaseUrl}/${profile['image']}')
                          : const AssetImage(AppImages.profile) as ImageProvider,
                      onBackgroundImageError: (_, __) {
                        debugPrint('Failed to load network image.');
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: size.width * 0.05,
                          child: Icon(Icons.camera_alt, size: size.width * 0.05, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),
                _buildProfileTextField('Name', nameController, hintText: profile['name']),
                _buildProfileTextField('Address', addressController, hintText: profile['address']),
                _buildProfileTextField('Gender', genderController, hintText: profile['gender']),
                _buildProfileTextField('Age', ageController, isNumeric: true, hintText: profile['age']?.toString()),
                _buildProfileTextField('Height (CM)', heightController, isNumeric: true, hintText: profile['height']?.toString()),
                _buildProfileTextField('Weight (KG)', weightController, isNumeric: true, hintText: profile['weight']?.toString()),
                SizedBox(height: size.height * 0.03),
                CustomTextButton(
                  text: 'Update Profile',
                  onTap: () {
                    Get.back();
                    _updateProfileController.updateProfile(
                      userId: widget.userId,
                      name: nameController.text.isEmpty ? profile['name'] ?? '' : nameController.text,
                      address: addressController.text.isEmpty ? profile['address'] ?? '' : addressController.text,
                      gender: genderController.text.isEmpty ? profile['gender'] ?? '' : genderController.text,
                      age: int.tryParse(ageController.text) ?? profile['age'],
                      height: double.tryParse(heightController.text) ?? profile['height'],
                      weight: double.tryParse(weightController.text) ?? profile['weight'],
                      profileImage: _profileImage, // Pass the image file
                    );
                  },
                ),

              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileTextField(String label, TextEditingController controller, {bool isNumeric = false, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.black54),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
