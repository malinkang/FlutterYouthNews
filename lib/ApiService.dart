import 'package:dio/dio.dart';
import 'package:news/CustomInterceptor.dart';
import 'package:news/bean/Article.dart';
import 'package:news/bean/ArticleResponse.dart';
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

  Future<List<Category>> getVideoCategory() async {
    var response = await dio.get("v3/user/getvideocate.json");
    if (response.statusCode == 200) {
      return CategroyResponse.fromJson(response.data).list;
    } else {
      throw Exception('Failed to load album');
    }
  }

  //获取文章
  Future<List<Article>> getArticle(String id, int isRefresh, String behotTime,
      String oid, String step, String videoId) async {
    var parameters = Map<String, dynamic>();
    parameters['catid'] = id;
    parameters['op'] = isRefresh;
    parameters['behot_time'] = behotTime;
    parameters['oid'] = oid;
    parameters['step'] = step;
    parameters['video_catid'] = videoId;
    var response =
        await dio.get("v3/article/lists.json", queryParameters: parameters);
    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(response.data).list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
