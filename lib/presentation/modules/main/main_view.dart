import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());

    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.screens[controller.currentIndex.value],
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_outlined),
              activeIcon: Icon(Icons.local_drink),
              label: 'CUP',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell),
              activeIcon: Icon(CupertinoIcons.bell_fill),
              label: 'REMINDERS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: 'PROGRESS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'SETTINGS',
            ),
          ],
        )),
      ),
    );
  }
}
