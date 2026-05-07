import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import '../cup_selection/cup_selection_view.dart';
import 'hydration_controller.dart';

class DashboardView extends GetView<HydrationController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HydrationController());
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.dropMedium,
                        child: Icon(Icons.person, color: Colors.white),
                      ).animate().scale(),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, User!',
                            style: textTheme.bodySmall?.copyWith(color: AppColors.textGrey),
                          ),
                          Text(
                            'HydraTrack',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms).slideX(),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.bell_fill),
                      onPressed: () {},
                    ),
                  ).animate().scale(delay: 400.ms),
                ],
              ),
              const SizedBox(height: 40),

              // Circular Progress
              Center(
                child: Obx(() => CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 18.0,
                  animation: true,
                  animateFromLastPercent: true,
                  percent: controller.progress,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${controller.currentIntake.value}',
                            style: textTheme.displayMedium?.copyWith(
                              color: AppColors.primary,
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            ' / ${controller.dailyGoal.value}',
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.primary.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ml',
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.textGrey,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(controller.progress * 100).toInt()}% Done',
                          style: textTheme.labelMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Get.isDarkMode ? AppColors.progressBarBackgroundDark : AppColors.progressBarBackground,
                  progressColor: AppColors.primary,
                  curve: Curves.easeInOut,
                )).animate().scale(duration: 800.ms, curve: Curves.bounceOut),
              ),
              const SizedBox(height: 48),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuickActionButton(
                    icon: Icons.add,
                    label: 'Add ${controller.selectedCup.amount}ml',
                    onTap: () => controller.addWater(controller.selectedCup.amount),
                  ),
                  _QuickActionButton(
                    icon: Icons.local_drink,
                    label: 'Select Cup',
                    onTap: () => Get.to(() => const CupSelectionView()),
                  ),
                  _QuickActionButton(
                    icon: Icons.refresh,
                    label: 'Reset',
                    onTap: () => controller.resetIntake(),
                    color: Colors.orangeAccent,
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),

              const SizedBox(height: 40),

              // Upcoming Reminders Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Progress',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 16),

              // Simple Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Interval',
                      value: '45 min',
                      icon: CupertinoIcons.timer,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _StatCard(
                      title: 'Remaining',
                      value: '${controller.dailyGoal.value - controller.currentIntake.value}ml',
                      icon: CupertinoIcons.drop,
                      color: Colors.cyan,
                    )),
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (color ?? AppColors.primary).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color ?? AppColors.primary, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
