import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/reminder_model.dart';
import '../dashboard/hydration_controller.dart';
import 'reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RemindersController());
    final hydrationController = Get.find<HydrationController>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Reminders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Goal Progress Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Goal Progress',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(() => Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${hydrationController.currentIntake.value} ',
                                style: textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '/ ${hydrationController.dailyGoal.value} ml',
                                style: textTheme.titleMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.water_drop, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: hydrationController.progress,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                    ),
                  )),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.2),
            
            const SizedBox(height: 32),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Schedule",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => Text(
                  '${controller.reminders.where((r) => r.isActive).length} Active',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 20),
            
            // Schedule List
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.reminders.length,
              itemBuilder: (context, index) {
                final reminder = controller.reminders[index];
                return _ReminderListItem(
                  reminder: reminder,
                  onToggle: () => controller.toggleReminder(reminder.id),
                ).animate().fadeIn(delay: (300 + (index * 100)).ms).slideX(begin: 0.1);
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _ReminderListItem extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onToggle;

  const _ReminderListItem({
    required this.reminder,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isActive = reminder.isActive;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.04 : 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isActive ? AppColors.primary : AppColors.textGrey).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_filled,
              color: isActive ? AppColors.primary : AppColors.textGrey,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.time,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isActive ? null : AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${reminder.title} • ${reminder.amount} ml',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (val) => onToggle(),
          ),
        ],
      ),
    );
  }
}
