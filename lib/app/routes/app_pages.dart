import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/newsDetailsPage/bindings/news_details_page_binding.dart';
import '../modules/newsDetailsPage/views/news_details_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAILS_PAGE,
      page: () => const NewsDetailsPageView(),
      binding: NewsDetailsPageBinding(),
    ),
  ];
}
