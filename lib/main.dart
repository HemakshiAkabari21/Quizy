import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:quizy/screens/auth_screen/login_screen/login_screen.dart';

import 'app_theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (_, widget) {
        return  GetMaterialApp(
          title: 'Quizy',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            return GetPageRoute(page: () => const /*MainScreen(currentIndex: 0)*/LoginScreen());
          },
          useInheritedMediaQuery: true,
        );
      },
    );
  }
}
