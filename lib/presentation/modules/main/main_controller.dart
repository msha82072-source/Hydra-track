import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard/dashboard_view.dart';
import '../reminders/reminders_view.dart';
import '../progress/progress_view.dart';
import '../settings/settings_view.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  final List<Widget> screens = [
    const DashboardView(),
    const RemindersView(),
    const ProgressView(),
    const SettingsView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
