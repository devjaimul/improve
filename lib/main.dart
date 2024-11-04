import 'package:Improve.Ai/controller/auth_controller.dart';
import 'package:Improve.Ai/controller/controller_bindings.dart';
import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/routes/routes_page.dart';
import 'package:Improve.Ai/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthController.getUserAccessToken();
  bool isLoggedIn = await AuthController.checkAuthState();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: lightTheme(context),
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBindings(), // Ensure all controllers are initialized here
          getPages: RoutePages.routes,
          initialRoute: isLoggedIn ? RouteNames.navBar : RouteNames.signInScreen,
        );
      },
    );
  }
}
