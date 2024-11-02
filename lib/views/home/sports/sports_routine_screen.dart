import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sports_generate_screen.dart';

class SportsRoutineScreen extends StatefulWidget {
  const SportsRoutineScreen({super.key});

  @override
  _SportsRoutineScreenState createState() => _SportsRoutineScreenState();
}

class _SportsRoutineScreenState extends State<SportsRoutineScreen> {
  // Controllers for text fields
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController intentionsController = TextEditingController();

  // Dropdown values
  String? selectedGender;
  String? selectedPlanLength = '4 days';
  String? selectedBudget = 'None';

  @override
  void dispose() {
    // Dispose controllers when the screen is disposed
    genderController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    intentionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Generate Plan'),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: EdgeInsets.all(sizeH * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField('Your Gender', ['Male', 'Female', 'Other'],
                selectedValue: selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),
              _buildTextField('Your Age', ageController),
              SizedBox(height: sizeH * 0.02),
              _buildTextField('Your Height', heightController),
              SizedBox(height: sizeH * 0.02),
              _buildTextField('Your Weight', weightController),
              SizedBox(height: sizeH * 0.02),
              _buildTextField('Plan Intentions', intentionsController),
              SizedBox(height: sizeH * 0.02),
              _buildDropdownField('Plan Length in Weeks', ['4 days', '1 week', '2 weeks'],
                selectedValue: selectedPlanLength,
                onChanged: (String? value) {
                  setState(() {
                    selectedPlanLength = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),
              _buildDropdownField('Budget', ['None', 'Low', 'Medium', 'High'],
                selectedValue: selectedBudget,
                onChanged: (String? value) {
                  setState(() {
                    selectedBudget = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.04),

              CustomTextButton(text:'Generate Routine', onTap: () {
                Get.to(const SportsGenerateScreen());
                final routineData = {
                  "gender": selectedGender,
                  "age": ageController.text,
                  "height": heightController.text,
                  "weight": weightController.text,
                  "intentions": intentionsController.text,
                  "planLength": selectedPlanLength,
                  "budget": selectedBudget,
                };
              })
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a TextField for input
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        helperText: label, // Use helperText to display above the text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  // Function to build a Dropdown for selection
  Widget _buildDropdownField(String label, List<String> options, {String? selectedValue, ValueChanged<String?>? onChanged}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        helperText: label, // Use helperText for dropdown as well
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: selectedValue,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
