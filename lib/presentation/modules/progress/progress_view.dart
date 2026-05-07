import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import '../dashboard/hydration_controller.dart';

class ProgressView extends GetView<HydrationController> {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Progress'),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Visual Goal Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  const Icon(Icons.water_drop, size: 80, color: AppColors.primary)
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: -5, end: 5, duration: 2000.ms),
                  const SizedBox(height: 24),
                  Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${controller.currentIntake.value} ',
                          style: textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '/ ${controller.dailyGoal.value} ml',
                          style: textTheme.bodyLarge?.copyWith(color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ).animate().fadeIn().scale(),
            
            const SizedBox(height: 32),

            // Progress Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Today's Progress", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      Obx(() => Text(
                        '${(controller.progress * 100).toInt()}%',
                        style: textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: controller.progress,
                      backgroundColor: Get.isDarkMode ? AppColors.progressBarBackgroundDark : AppColors.progressBarBackground,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 12,
                    ),
                  )),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                    '${controller.dailyGoal.value - controller.currentIntake.value} ml remaining to reach your goal',
                    style: textTheme.labelMedium?.copyWith(color: AppColors.textGrey),
                  )),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

            const SizedBox(height: 32),

            // Weekly Stats Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Weekly Overview', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ).animate().fadeIn(delay: 400.ms),
            
            const SizedBox(height: 16),
            
            // Dummy Weekly Chart (Simplified)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _WeekDayBar(day: 'M', height: 0.8),
                _WeekDayBar(day: 'T', height: 0.6),
                _WeekDayBar(day: 'W', height: 0.9, isToday: true),
                _WeekDayBar(day: 'T', height: 0.4),
                _WeekDayBar(day: 'F', height: 0.7),
                _WeekDayBar(day: 'S', height: 0.5),
                _WeekDayBar(day: 'S', height: 0.3),
              ],
            ).animate().fadeIn(delay: 600.ms),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _WeekDayBar extends StatelessWidget {
  final String day;
  final double height;
  final bool isToday;

  const _WeekDayBar({required this.day, required this.height, this.isToday = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 30,
          decoration: BoxDecoration(
            color: isToday ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 100 * height,
                width: 12,
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : AppColors.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? AppColors.primary : AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
