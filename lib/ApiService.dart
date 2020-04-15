import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news/CustomInterceptor.dart';
import 'package:news/bean/Category.dart';
import 'package:news/bean/CategroyResponse.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  Dio dio;

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: "https://kd.youth.cn/",
        connectTimeout: 3000,
        receiveTimeout: 3000);
    dio = Dio(options);
    var interceptors = dio.interceptors;
    interceptors.add(CustomInterceptor());
    interceptors.add(LogInterceptor());
  }

  //获取文章分类
  Future<List<Category>> getArticleCategory() async {
    var response = await dio.get("v3/user/getinfo.json");
    if (response.statusCode == 200) {
     return CategroyResponse.fromJson(response.data).list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
