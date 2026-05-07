import 'package:get/get.dart';
import '../../presentation/modules/main/main_view.dart';
import '../../presentation/modules/splash/splash_view.dart';
import '../../presentation/modules/cup_selection/cup_selection_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.CUP_SELECTION,
      page: () => const CupSelectionView(),
      transition: Transition.cupertino,
    ),
  ];
}
