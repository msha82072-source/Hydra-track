import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import 'theme_controller.dart';

class SettingsView extends GetView<ThemeController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Settings'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Reset'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('THEME SETTINGS', textTheme),
            _buildCardList([
              GetBuilder<ThemeController>(
                builder: (controller) => _SettingsItem(
                  icon: Icons.brightness_6,
                  title: 'Dark Mode',
                  trailingWidget: Switch(
                    value: controller.isDarkMode,
                    onChanged: (val) => controller.switchTheme(),
                  ),
                ),
              ),
              GetBuilder<ThemeController>(
                builder: (controller) => _SettingsItem(
                  icon: Icons.nightlight_round,
                  title: 'Amoled Black',
                  trailingWidget: Switch(
                    value: controller.isBlackMode,
                    onChanged: (val) => controller.toggleBlackMode(val),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 24),
            
            _buildSectionHeader('REMINDER SETTINGS', textTheme),
            _buildCardList([
              const _SettingsItem(
                icon: Icons.access_time_filled,
                title: 'Schedule',
                trailingValue: 'Every 2 hours',
                showChevron: true,
              ),
              const _SettingsItem(
                icon: Icons.notifications_active,
                title: 'Sound',
                trailingValue: 'Nature Breeze',
                showChevron: true,
              ),
              const _SettingsItem(
                icon: Icons.flash_on,
                title: 'Smart Alerts',
                trailingWidget: Switch(value: true, onChanged: null),
              ),
            ]),
            const SizedBox(height: 24),

            _buildSectionHeader('GENERAL SETTINGS', textTheme),
            _buildCardList([
              const _SettingsItem(
                icon: Icons.straighten,
                title: 'Volume Unit',
                trailingValue: 'ml (Milliliters)',
              ),
              const _SettingsItem(
                icon: Icons.language,
                title: 'Language',
                trailingValue: 'English (US)',
              ),
            ]),
            const SizedBox(height: 24),

            _buildSectionHeader('PERSONAL DATA', textTheme),
            _buildCardList([
              const _SettingsItem(
                icon: Icons.person,
                title: 'Gender',
                trailingValue: 'Male',
              ),
              const _SettingsItem(
                icon: Icons.monitor_weight,
                title: 'Weight',
                trailingValue: '78 kg',
              ),
            ]),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red.withOpacity(0.2)),
                  backgroundColor: Colors.red.withOpacity(0.05),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('Clear All Data', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.1),
    );
  }

  Widget _buildSectionHeader(String title, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 8.0),
      child: Text(
        title,
        style: textTheme.labelMedium?.copyWith(
          color: AppColors.textGrey,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildCardList(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
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
        children: List.generate(items.length, (index) {
          return Column(
            children: [
              items[index],
              if (index < items.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Get.isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.05),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingValue;
  final Widget? trailingWidget;
  final bool showChevron;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailingValue,
    this.trailingWidget,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (trailingWidget != null) trailingWidget!,
          if (trailingValue != null)
            Text(
              trailingValue!,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
            ),
          if (showChevron)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.chevron_right, color: AppColors.textLight, size: 20),
            ),
        ],
      ),
    );
  }
}
