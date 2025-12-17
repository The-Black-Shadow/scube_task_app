import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_theme.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/routes/app_routes_file.dart';
import 'package:scube_task_app/utils/app_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scube Task App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.instance.lightTheme,
      getPages: appRootRoutesFile,
      initialRoute: AppRoutes.instance.loginScreen,
      builder: (context, child) {
        AppSize.size = MediaQuery.of(context).size;
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
