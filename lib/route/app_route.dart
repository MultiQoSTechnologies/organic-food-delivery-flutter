import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screen/cart/add_to_cart_page.dart';
import '../screen/home/home_page.dart';
import '../screen/landing_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.landingPage,
      page: () => const LandingPage(),
    ),
    GetPage(
      name: Routes.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.addToCartPage,
      page: () => const AddToCartPage(),
    ),
  ];
}

abstract class Routes {
  static const landingPage = '/landingPage';
  static const homePage = '/homePage';
  static const addToCartPage = '/addToCartPage';
}
