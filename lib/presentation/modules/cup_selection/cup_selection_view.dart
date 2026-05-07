import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import '../dashboard/hydration_controller.dart';

class CupSelectionView extends GetView<HydrationController> {
  const CupSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Cup Size'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Add',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 8),
            Text(
              'Tap a size to log your water intake',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
            ).animate().fadeIn(delay: 100.ms).slideX(),
            const SizedBox(height: 32),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: controller.cups.length,
              itemBuilder: (context, index) {
                final cup = controller.cups[index];
                return Obx(() {
                  final isSelected = controller.selectedCupId.value == cup.id;
                  return GestureDetector(
                    onTap: () {
                      controller.selectCup(cup.id);
                      controller.addWater(cup.amount);
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Logged ${cup.amount}ml of water',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.primary,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                        margin: const EdgeInsets.all(16),
                        borderRadius: 20,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isSelected ? 0.1 : 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (isSelected ? AppColors.primary : AppColors.textGrey).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(cup.icon, color: isSelected ? AppColors.primary : AppColors.textGrey, size: 28),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${cup.amount} ml',
                            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cup.name,
                            style: textTheme.bodySmall?.copyWith(color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: (200 + (index * 100)).ms).scale();
                });
              },
            ),
            
            const SizedBox(height: 32),
            
            // Custom Amount Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showCustomAmountDialog(context);
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Custom Amount'),
              ),
            ).animate().fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }

  void _showCustomAmountDialog(BuildContext context) {
    final controller = TextEditingController();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text('Custom Amount'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter amount in ml',
            suffixText: 'ml',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final amount = int.tryParse(controller.text);
                if (amount != null) {
                  this.controller.addWater(amount);
                  Get.back();
                  Get.back();
                  Get.snackbar('Success', 'Logged $amount ml');
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
