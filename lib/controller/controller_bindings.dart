import 'package:Improve.Ai/controller/auth/otp_controller.dart';
import 'package:Improve.Ai/controller/auth/sign_up_controller.dart';
import 'package:Improve.Ai/controller/home/workout/workout_plan_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => WorkOutPlanController(), fenix: true); // Ensure the controller stays in memory if needed
  }
}
