import 'package:flutter/material.dart';
import 'package:organic_food_app/route/app_route.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      navigatorKey: Get.key,
      initialRoute: _initMainScreen(),
      getPages: AppPages.routes,
    );
  }

  String _initMainScreen() {
    return Routes.landingPage;
  }
}