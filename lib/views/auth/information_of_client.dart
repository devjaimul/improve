import 'package:Improve.Ai/controller/auth/info_controller.dart';
import 'package:Improve.Ai/controller/auth_controller.dart'; // Import AuthController
import 'package:Improve.Ai/global%20widget/app_logo.dart';
import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/app-strings.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationOfClient extends StatefulWidget {
  final String? userId;
  const InformationOfClient({super.key, this.userId});

  @override
  _InformationOfClientState createState() => _InformationOfClientState();
}

class _InformationOfClientState extends State<InformationOfClient> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final GlobalKey _genderFieldKey = GlobalKey();
  String? _selectedGender;
  final InformationController _infoController = Get.put(InformationController());

  @override
  void initState() {
    super.initState();
    // Debug to confirm the access token is set
    debugPrint('Current access token: ${AuthController.accessToken}');
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: HeadingTwo(data: AppString.signUpAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeW * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sizeH * .001),
              const AppLogo(),
              SizedBox(height: sizeH * .02),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined),
                  hintText: 'Your Address',
                ),
              ),
              SizedBox(height: sizeH * .02),
              GestureDetector(
                key: _genderFieldKey,
                onTap: () async {
                  final RenderBox renderBox =
                  _genderFieldKey.currentContext!.findRenderObject() as RenderBox;
                  final offset = renderBox.localToGlobal(Offset.zero);
                  final selected = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy + renderBox.size.height,
                      offset.dx,
                      offset.dy + renderBox.size.height + sizeH * .02,
                    ),
                    items: const [
                      PopupMenuItem(value: "Male", child: Text("Male")),
                      PopupMenuItem(value: "Female", child: Text("Female")),
                      PopupMenuItem(value: "Other", child: Text("Other")),
                      PopupMenuItem(value: "Prefer Not to say", child: Text("Prefer Not to say")),
                    ],
                  );
                  if (selected != null) {
                    setState(() {
                      _selectedGender = selected;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: _selectedGender ?? 'Please select your gender',
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ),
              SizedBox(height: sizeH * .02),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Your Age',
                ),
              ),
              SizedBox(height: sizeH * .02),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Your Height',
                ),
              ),
              SizedBox(height: sizeH * .02),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Your Weight',
                ),
              ),
              SizedBox(height: sizeH * .04),
              Obx(() {
                return CustomTextButton(
                  text: _infoController.isLoading.value ? 'Submitting...' : "Let's Go",
                  onTap: _infoController.isLoading.value
                      ? () {}
                      : () {
                    if (_addressController.text.isNotEmpty &&
                        _ageController.text.isNotEmpty &&
                        _heightController.text.isNotEmpty &&
                        _weightController.text.isNotEmpty &&
                        _selectedGender != null) {
                      // Convert age, height, and weight to appropriate data types
                      int? age = int.tryParse(_ageController.text);
                      double? height = double.tryParse(_heightController.text);
                      double? weight = double.tryParse(_weightController.text);

                      if (age != null && height != null && weight != null) {
                        _infoController.updateUserInfo(
                          userId: widget.userId.toString(),
                          address: _addressController.text,
                          age: age,  // Pass age as an integer
                          height: height.toString(), // Convert double to string if needed by the API
                          weight: weight.toString(), // Convert double to string if needed by the API
                          gender: _selectedGender!,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Age must be an integer, and Height and Weight must be numeric values.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Error',
                        'All fields are required!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
