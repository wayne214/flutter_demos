import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/article.dart';

class ArticleApi {
  static const String baseUrl = 'https://www.wanandroid.com';

  final Dio _client = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Article>> getArticles(int page) async {
    String path = '/article/list/$page/json';

    var rep = await _client.get(path);

    if (kDebugMode) {
      print("网络数据：$rep");
    }

    if(rep.statusCode == 200){
      if(rep.data != null) {
        var data = rep.data['data']['datas'] as List;
        return data.map(Article.formMap).toList();
      }
    }


    return [];
  }
}