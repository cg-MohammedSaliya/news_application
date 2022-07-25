import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/app/routes/app_pages.dart';
import 'package:news_application/app/ui/customTabBar.dart';
import 'package:news_application/app/ui/newsDetailsListCard.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.newspaper,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text(
                'Newsify',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'by ishandeeveloper',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.light_mode,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.warning,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
              ],
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            height: 80,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                customTabBar(
                  onPressed: () {
                    controller.category == "General";
                    controller.getNewsDeatilsApiCall('General');
                  },
                  btnText: 'General',
                ),
                customTabBar(
                  onPressed: () {
                    controller.category == "COVID-19";
                    controller.getNewsDeatilsApiCall('COVID-19');
                  },
                  btnText: 'COVID-19',
                ),
                customTabBar(
                  onPressed: () {
                    controller.category == "Business";
                    controller.getNewsDeatilsApiCall('Business');
                  },
                  btnText: 'Business',
                )
              ],
            ),
          ),
          Obx(
            () => controller.newsArticles.value.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.newsArticles.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewsDetailsListCard(
                            onPressed: () {
                              Get.toNamed(Routes.NEWS_DETAILS_PAGE,
                                  arguments: controller.newsArticles.value[index]);
                            },
                            newsImage: controller.newsArticles.value[index].urlToImage ?? "",
                            newsTittle: controller.newsArticles.value[index].title ?? "",
                            newsContent: controller.newsArticles.value[index].description ?? "",
                          );
                        }),
                  )
                : const Text('No data here',style: TextStyle(color: Colors.black,fontSize: 20),),
          )
        ]));
  }
}
