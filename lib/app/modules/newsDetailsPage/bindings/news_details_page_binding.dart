import 'package:get/get.dart';

import '../controllers/news_details_page_controller.dart';

class NewsDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsPageController>(
      () => NewsDetailsPageController(),
    );
  }
}
