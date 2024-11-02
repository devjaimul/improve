import 'package:flutter/material.dart';

import '../../../utlis/app_colors.dart';
import '../../../utlis/custom_text_style.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'Notification'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: sizeW*.016,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingThree(data: 'Today'),
                SizedBox(height: sizeH*.01,),
                Card(
                  color: Colors.black.withOpacity(0.3),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.notifications_none,size: sizeH*.03,color: AppColors.primaryColor,)),
                    title: const HeadingThree(data: 'Today’s Special Offers'),
                    subtitle:  HeadingThree(data: 'Customer’s  will get a special promo today.',fontSize: sizeH*.016,),
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),

    );
  }
}
