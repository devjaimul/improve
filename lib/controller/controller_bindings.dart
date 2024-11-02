import 'package:Improve.Ai/controller/auth/otp_controller.dart';
import 'package:Improve.Ai/controller/auth/sign_up_controller.dart';
import 'package:get/get.dart';


class ControllerBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => SignUpController(),);
    Get.lazyPut(() => OtpController(),);

  }
}