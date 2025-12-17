import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/routes/app_routes.dart';
import 'package:scube_task_app/routes/app_routes_file.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scube Task App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      getPages: appRootRoutesFile,
      initialRoute: AppRoutes.instance.loginScreen,
    );
  }
}
