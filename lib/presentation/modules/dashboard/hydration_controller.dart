import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/cup_model.dart';

class HydrationController extends GetxController {
  final _storage = GetStorage();
  
  var dailyGoal = 2000.obs;
  var currentIntake = 0.obs;
  var selectedCupId = 'glass'.obs;

  final List<Cup> cups = [
    Cup(id: 'glass', name: 'Glass', amount: 200, icon: Icons.local_drink),
    Cup(id: 'bottle', name: 'Bottle', amount: 500, icon: Icons.straighten),
    Cup(id: 'mug', name: 'Mug', amount: 350, icon: Icons.coffee),
    Cup(id: 'small', name: 'Small Cup', amount: 100, icon: Icons.wine_bar),
  ];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    dailyGoal.value = _storage.read('dailyGoal') ?? 2000;
    currentIntake.value = _storage.read('currentIntake') ?? 0;
    selectedCupId.value = _storage.read('selectedCupId') ?? 'glass';
  }

  void addWater(int amount) {
    currentIntake.value += amount;
    _storage.write('currentIntake', currentIntake.value);
  }

  void resetIntake() {
    currentIntake.value = 0;
    _storage.write('currentIntake', 0);
  }

  void setDailyGoal(int goal) {
    dailyGoal.value = goal;
    _storage.write('dailyGoal', goal);
  }

  void selectCup(String id) {
    selectedCupId.value = id;
    _storage.write('selectedCupId', id);
  }

  double get progress => (currentIntake.value / dailyGoal.value).clamp(0.0, 1.0);
  
  Cup get selectedCup => cups.firstWhere((c) => c.id == selectedCupId.value);
}
