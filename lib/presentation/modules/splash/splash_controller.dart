import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(Routes.MAIN);
  }
}
