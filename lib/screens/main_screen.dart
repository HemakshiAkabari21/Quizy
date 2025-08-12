import 'package:animated_loader_demo_flutter/app_theme/app_colors.dart';
import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:animated_loader_demo_flutter/screens/profile_screen/profile_screen.dart';
import 'package:animated_loader_demo_flutter/screens/store_screen/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'histroy_screen/history_screen.dart';
import 'home_Screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;
  const MainScreen({super.key, required this.currentIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController(changeTab), permanent: true);

    final List<Widget> screens = [
      HomeScreen(onTabChange: changeTab),
      HistoryScreen(),
      StoreScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGray,
              blurRadius: 4,
              offset: Offset(0, -2),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavItem(Icons.description, 0 , 'Practice'),
            buildNavItem(Icons.history, 1 , 'History'),
            buildNavItem(Icons.store, 2 , 'Store'),
            buildNavItem(Icons.person_2_outlined, 3 , 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index , String tabName) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: isSelected ? AppColors.black : Colors.blueAccent,size: 24.sp,).paddingOnly(bottom: 4.h),
          Text(tabName,style: StyleHelper.customStyle(color: isSelected ? AppColors.black : Colors.blueAccent,size: 12.sp,family: semiBold ),)
        ],
      ),
    );
  }
}

class MainScreenController extends GetxController {
  final Function(int) changeTab;

  MainScreenController(this.changeTab);

  void switchTab(int index) {
    changeTab(index);
  }
}