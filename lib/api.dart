import 'package:dio/dio.dart';
import 'package:news/CustomInterceptor.dart';
import 'package:news/bean/Article.dart';
import 'package:news/bean/ArticleResponse.dart';
import 'package:news/bean/Category.dart';
import 'package:news/bean/CategroyResponse.dart';
import 'package:news/bean/ShortVideoResponse.dart';
import 'package:news/bean/short_video.dart';
import 'package:news/bean/user_center_model.dart';
import 'package:news/bean/user_center_response.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  Dio dio;
  Dio dio2;

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
    interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
    BaseOptions options2 = BaseOptions(
        baseUrl: "https://content.youth.cn/",
        connectTimeout: 3000,
        receiveTimeout: 3000);
    dio2 = Dio(options2);
    var interceptors2 = dio2.interceptors;
    interceptors2.add(CustomInterceptor());
    interceptors2.add(LogInterceptor(requestBody: true,responseBody: true));
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

  //获取文章
  Future<List<ShortVideo>>  getShortVideo(int isRefresh, String behotTime,
      String count) async {
    FormData formData = FormData.fromMap(
      {
        'op':isRefresh,
        'behot_time':behotTime,
        'count':count
      }
    );
    var response =
    await dio2.post("v16/api/content/short_video/recommend", data: formData);
    if (response.statusCode == 200) {
      return ShortVideoResponse.fromJson(response.data).list;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Article>>  getRelateArticle(String id) async {
    FormData formData = FormData.fromMap(
        {
          'id':id
        }
    );
    var response =
    await dio2.post("v16/api/content/video/relate", data: formData);
    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(response.data).list;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<UserCenterModel>> getUserCenter() async{
    var response = await dio.get("v14/user/center.json");
    if(response.statusCode==200){
      return UserCenterResponse.fromJson(response.data).list;
    }else{
      throw Exception('Failed to load album');
    }
  }


}
