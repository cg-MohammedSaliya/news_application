import 'package:news_application/app/models/news_details_model.dart';

import 'common/api_data_provider.dart';

class InnerPageProvider extends ApiDataProvider {
  InnerPageProvider._();

  static InnerPageProvider instance = InnerPageProvider._();


  Future<NewsDetails?> getNewsDetails({required String country, required String category,required String apiKey }) async {
     Map<String, dynamic>? res = await getApi('/top-headlines?country=in&category=$category&apiKey=24802f736c1d41889bb99f0e5b9c8ea2',
    // body: {
    //   'country': country,
    //   'category': category,
    //   'apiKey': apiKey,
    //
    // }
     );
    if (res != null) {
      NewsDetails newsDetails = NewsDetails.fromJson(res);
      return newsDetails;
    }
    return null;
  }
}
