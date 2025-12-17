import 'package:get/get.dart';
import 'package:scube_task_app/screens/login_screen/login_screen_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
  }
}
