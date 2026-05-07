import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inject controller if not already done by routing
    Get.put(SplashController());
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Custom Water Drop Logo with Animation
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dropLight.withOpacity(0.3),
                  ),
                ).animate().scale(duration: 1000.ms, curve: Curves.easeOutBack),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dropMedium.withOpacity(0.5),
                  ),
                ).animate().scale(delay: 200.ms, duration: 1000.ms, curve: Curves.easeOutBack),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dropDark,
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 40,
                  ),
                ).animate().scale(delay: 400.ms, duration: 1000.ms, curve: Curves.easeOutBack)
                 .animate(onPlay: (controller) => controller.repeat())
                 .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'HydraTrack',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.5, end: 0),
            const SizedBox(height: 8),
            Text(
              'STAY HYDRATED, STAY HEALTHY',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.primary,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 800.ms),
            const Spacer(),
            // Progress Bar Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PREPARING YOUR DASHBOARD',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          letterSpacing: 1.0,
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 100),
                        duration: const Duration(seconds: 3),
                        builder: (context, value, child) => Text(
                          '${value.toInt()}%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      backgroundColor: AppColors.progressBarBackground,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 6,
                    ),
                  ).animate().fadeIn(delay: 1000.ms).scaleX(begin: 0.5),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
