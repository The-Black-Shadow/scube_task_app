import 'package:get/get.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/routes/all_binding.dart';
import 'package:scube_task_app/screens/login_screen/login_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  GetPage(
    name: AppRoutes.instance.loginScreen,
    binding: AllBinding(),
    page: () => const LoginScreen(),
  ),
];
