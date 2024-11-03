import 'package:Improve.Ai/global%20widget/custom_button.dart';
import 'package:Improve.Ai/utlis/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'meal_generate_screen.dart';


class MealRoutineScreen extends StatefulWidget {
  const MealRoutineScreen({super.key});

  @override
  _MealRoutineScreenState createState() => _MealRoutineScreenState();
}

class _MealRoutineScreenState extends State<MealRoutineScreen> {
  // Controllers for text fields
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // Popup menu values
  String? selectedGender = 'Select Gender';
  String? selectedExperience = 'Select Experience';
  String? selectedKnowledge = 'Select Knowledge';
  String? selectedIntention = 'Select Intention';
  String? selectedPlanLength = 'Select Plan Length';
  String? selectedGymAccess = 'Select GymAccess';
  String? selectedBudget = 'Select Budget';
  String? selectedSport = 'Select Sport';
  String? selectedSessions = 'Select Sessions';
  String? selectedSportDays = 'Select SportDays';

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
              _buildLabel('Gender'),
              _buildPopupMenuField(
                ['Male', 'Female', 'Prefer not to say'],
                selectedValue: selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Age'),
              _buildTextField(ageController, TextInputType.number),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Weight (KG)'),
              _buildTextField(weightController, TextInputType.number),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Height (CM)'),
              _buildTextField(heightController, TextInputType.number),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Gym Experience in Years'),
              _buildPopupMenuField(
                ['Less than 6 months', 'Less than a year', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                selectedValue: selectedExperience,
                onChanged: (String? value) {
                  setState(() {
                    selectedExperience = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Gym Knowledge'),
              _buildPopupMenuField(
                ['Excellent', 'Good', 'Average', 'Bad', 'Zero'],
                selectedValue: selectedKnowledge,
                onChanged: (String? value) {
                  setState(() {
                    selectedKnowledge = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Gym Intention'),
              _buildPopupMenuField(
                ['Lean bulk', 'Bulk', 'Maintain shape', 'Shred', 'Lose weight', 'Improve strength', 'Improve cardio'],
                selectedValue: selectedIntention,
                onChanged: (String? value) {
                  setState(() {
                    selectedIntention = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Sessions Training Per Week'),
              _buildPopupMenuField(
                List.generate(14, (index) => (index + 1).toString()),
                selectedValue: selectedSessions,
                onChanged: (String? value) {
                  setState(() {
                    selectedSessions = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Plan Length'),
              _buildPopupMenuField(
                ['2 weeks', '4 weeks', '8 weeks (week 1-4)', '8 weeks (week 4-8)', '12 weeks (week 1-4)', '12 weeks (week 4-8)', '12 weeks (week 8-12)'],
                selectedValue: selectedPlanLength,
                onChanged: (String? value) {
                  setState(() {
                    selectedPlanLength = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Do you have access to a gym?'),
              _buildPopupMenuField(
                ['Yes', 'No'],
                selectedValue: selectedGymAccess,
                onChanged: (String? value) {
                  setState(() {
                    selectedGymAccess = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Budget'),
              _buildPopupMenuField(
                ['No Budget', 'Low Budget'],
                selectedValue: selectedBudget,
                onChanged: (String? value) {
                  setState(() {
                    selectedBudget = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Sport'),
              _buildPopupMenuField(
                ['Soccer', 'Basketball', 'Rugby', 'Cricket', 'Padel', 'Pickleball', 'Jiu Jitsu', 'Boxing', 'Kickboxing', 'Tennis', 'Weightlifting', 'Powerlifting', 'Karate', 'Baseball', 'Softball', 'Hockey', 'Marathon', 'Volleyball', 'Hyrox', '100 meters', '400 meters', '5 kilometers'],
                selectedValue: selectedSport,
                onChanged: (String? value) {
                  setState(() {
                    selectedSport = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.02),

              _buildLabel('Days Training Sport per Week'),
              _buildPopupMenuField(
                List.generate(7, (index) => (index + 1).toString()),
                selectedValue: selectedSportDays,
                onChanged: (String? value) {
                  setState(() {
                    selectedSportDays = value;
                  });
                },
              ),
              SizedBox(height: sizeH * 0.04),

              CustomTextButton(
                  text: 'Generate Routine',
                  onTap: () {
                    Get.to(const MealGenerateScreen());
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a label for inputs
  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: HeadingThree(data: label),
    );
  }

  // Function to build a TextField for input
  Widget _buildTextField(TextEditingController controller, TextInputType textInputType) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
    );
  }

  // Function to build a PopupMenu for selection with rounded corners and full clickability
  Widget _buildPopupMenuField(List<String> options,
      {String? selectedValue, ValueChanged<String?>? onChanged}) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) async {
        // Use details.globalPosition to align the popup to the dropdown icon
        final String? result = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx, // X position of the dropdown icon
            details.globalPosition.dy, // Y position of the dropdown icon
            details.globalPosition.dx, // Same X to keep it aligned on the right
            details.globalPosition.dy + 50, // Offset to ensure it's under the dropdown
          ),
          items: options.map((String option) {
            return PopupMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        );

        if (result != null && onChanged != null) {
          onChanged(result);
        }
      },
      child: Container(
        height: 45.h, // Adjust the height here
        width: double.infinity, // Full width
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r), // Rounded corners
          border: Border.all(color: Colors.grey), // Border styling
          color: Colors.white, // Background color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? 'Select',
              style: TextStyle(
                color: selectedValue == null ? Colors.grey : Colors.black,
              ),
            ),
            Icon(Icons.arrow_drop_down, size: 24.h), // Dropdown icon size
          ],
        ),
      ),
    );
  }
}
