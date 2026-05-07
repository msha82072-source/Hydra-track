import 'package:get/get.dart';
import '../../presentation/modules/dashboard/hydration_controller.dart';
import '../../presentation/modules/settings/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(HydrationController());
  }
}
