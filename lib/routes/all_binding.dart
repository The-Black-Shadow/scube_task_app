import 'package:get/get.dart';
import 'package:scube_task_app/screens/login_screen/login_screen_controller.dart';
import 'package:scube_task_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:scube_task_app/screens/listitem_details_screen/listitem_details_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => ListItemDetailsController());
  }
}
