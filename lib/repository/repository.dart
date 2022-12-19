import 'package:dio/dio.dart';

import '../model/aritcals_response.dart';
import '../model/source_response.dart';

class NewsRepository {
  static String mainurl = 'https://newsapi.org/v2/';
  final String apikey = 'c490a06ac6364c9da7171e5b7331e044';

  final Dio dio = Dio();
  var getSourcesUrl = '$mainurl/sources';

  var getTopHeadUrl = '$mainurl/top-headlines';

  var everythingUrl = '$mainurl/everything';


  Future<SourceResponse> getSources() async
  {
    var params = {
      'apiKey': apikey,
      'language': 'en',
      'country': 'us'
    };
    try {
      Response response = await dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    }
    catch (e) {
      return SourceResponse.withError(e.toString());
    }
  }


  Future<AritcalResponse> getTopHead() async
  {
    var params = {
      'apiKey': apikey,
      'language': 'en',
    };
    try {
      Response response = await dio.get(getTopHeadUrl, queryParameters: params);
      return AritcalResponse.fromJson(response.data);
    }
    catch (e) {
      return AritcalResponse.withError(e.toString());
    }
  }

  Future<AritcalResponse> getHotNews() async
  {
    var params = {
      'apiKey': apikey,
      'q': 'apple',
      'sortBy': 'popularity',
    };
    try {
      Response response = await dio.get(everythingUrl, queryParameters: params);
      return AritcalResponse.fromJson(response.data);
    }
    catch (e) {
      return AritcalResponse.withError(e.toString());
    }
  }

  Future<AritcalResponse> getSourceNews(String sourceId) async
  {
    var params = {
      'apiKey': apikey,
      'sources': sourceId,
    };
    try {
      Response response = await dio.get(getTopHeadUrl, queryParameters: params);
      return AritcalResponse.fromJson(response.data);
    }
    catch (e) {
      return AritcalResponse.withError(e.toString());
    }
  }


  Future<AritcalResponse> search(String sourceId) async
  {
    var params = {
      'apiKey': apikey,
      'q': sourceId,
    };
    try {
      Response response = await dio.get(getTopHeadUrl, queryParameters: params);
      return AritcalResponse.fromJson(response.data);
    }
    catch (e) {
      return AritcalResponse.withError(e.toString());
    }
  }



}