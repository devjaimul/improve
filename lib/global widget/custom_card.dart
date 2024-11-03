import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utlis/custom_text_style.dart';
import 'custom_button.dart';

class CustomCard extends StatelessWidget {
  final String img; // URL or asset path for the image
  final String title;
  final String buttonText;
  final VoidCallback onTap;
  final Color? bgColor;

  const CustomCard({
    super.key,
    required this.img,
    required this.title,
    required this.buttonText,
    required this.onTap,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: double.infinity,
      height: sizeH*.24,

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(sizeH * .022),
            child: _buildImage(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(sizeH * .02),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(sizeH * .03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: sizeW * .5,
                  child: HeadingTwo(data: title),
                ),
                SizedBox(
                  width: sizeW * .5,
                  child: CustomTextButton(
                    color: bgColor,
                    text: buttonText,
                    onTap: onTap,
                    padding: sizeH * .002,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Check if the image path is a URL (network image) or a local asset.
    if (Uri.tryParse(img)?.hasAbsolutePath ?? false) {
      return SizedBox(
        height: 180.h, // Adjust this value to your preferred height
        width: double.infinity,
        child: Image.network(
          img,
          fit: BoxFit.cover, // This will crop the image to fit within the given size
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Image not available'));
          },
        ),
      );
    } else {
      return SizedBox(
        height: 180, // Adjust this value to your preferred height
        width: double.infinity,
        child: Image.asset(
          img,
          fit: BoxFit.cover, // Crop the image to fit
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Image not available'));
          },
        ),
      );
    }
  }

}
