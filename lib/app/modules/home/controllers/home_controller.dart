import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:news_application/app/data/data_provider/innerdata_provider.dart';
import 'package:news_application/app/models/news_details_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  Rx<String> selectedTab = Rx<String>('All');
  final Rxn<NewsDetails> newsDetails = Rxn<NewsDetails>();
  final Rx<List<Articles>> newsArticles = Rx<List<Articles>>([]);

  String country = 'in';
  String category = 'business' ;
  String apiKey = '24802f736c1d41889bb99f0e5b9c8ea2';

  @override
  Future<void> onInit() async {
    await getNewsDeatilsApiCall(category);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getNewsDeatilsApiCall(
    String category,
  ) async {
    newsDetails.value = await InnerPageProvider.instance.getNewsDetails(country: country, category: category, apiKey: apiKey);
    if (kDebugMode) {
      print("category=====>$category");
      print("Status=====>${newsDetails.value}");
    }
    newsArticles.value = newsDetails.value?.articles ?? [];
  }
}
