import 'package:Improve.Ai/routes/routes_name.dart';
import 'package:Improve.Ai/views/auth/forget_pass_screen.dart';

import 'package:Improve.Ai/views/auth/reset_pass_screen.dart';
import 'package:Improve.Ai/views/auth/sign_in_screen.dart';
import 'package:Improve.Ai/views/auth/sign_up_screen.dart';
import 'package:Improve.Ai/views/bottom%20navigationBar/custom_navbar.dart';
import 'package:Improve.Ai/views/home/home_screen.dart';
import 'package:Improve.Ai/views/home/workout/workout_screen.dart';
import 'package:Improve.Ai/views/splash%20screen/splash_screen.dart';
import 'package:get/get.dart';

import '../views/auth/information_of_client.dart';
import '../views/splash screen/onboarding_screen.dart';


class RoutePages {
  static List<GetPage<dynamic>>? routes = [

    GetPage(name: RouteNames.splashScreen, page: () =>const SplashScreen()),
    GetPage(name: RouteNames.onboardingScreen, page: () =>const OnboardingScreen()),
    GetPage(name: RouteNames.signInScreen, page: () =>const SignInScreen()),
    GetPage(name: RouteNames.singUpScreen, page: () =>const SignUpScreen()),
    GetPage(name: RouteNames.informationOfClient, page: () =>const InformationOfClient()),
    GetPage(name: RouteNames.forgetPassScreen, page: () =>const ForgetPassScreen()),
  //GetPage(name: RouteNames.otpVerificationScreen, page: () =>const OtpVerificationScreen()),
   // GetPage(name: RouteNames.resetPassScreen, page: () =>const ResetPassScreen()),
    GetPage(name: RouteNames.navBar, page: () =>const CustomNavbar()),
    GetPage(name: RouteNames.workOutScreen, page: () =>const WorkoutScreen()),
    GetPage(name: RouteNames.homeScreen, page: () =>const HomeScreen()),

  ];
}