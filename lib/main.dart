import 'package:datting_social/intro.dart';
import 'package:datting_social/router/app_page.dart';
import 'package:datting_social/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.white,
      initialRoute: AppRoutes.intro,
      getPages: AppPages.listPage,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
