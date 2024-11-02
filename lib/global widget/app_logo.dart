
import 'package:flutter/material.dart';

import '../utlis/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return Image.asset(
      AppImages.logoBlack,
      height: sizeH * .3,
      width: sizeW * .7,
    );
  }
}