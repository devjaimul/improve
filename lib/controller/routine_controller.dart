import 'package:get/get.dart';

class RoutineController extends GetxController {
  bool isRoutineConfirmed = false;

  void confirmRoutine() {
    isRoutineConfirmed = true;
    update();
  }
}
