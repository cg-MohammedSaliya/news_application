import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_application/app/models/news_details_model.dart';

import '../controllers/news_details_page_controller.dart';

class NewsDetailsPageView extends GetView<NewsDetailsPageController> {
  const NewsDetailsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Articles data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
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
          IconButton(
            icon: const Icon(
              Icons.warning,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Text(
          '${data.content}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
