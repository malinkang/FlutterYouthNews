import 'package:news/bean/Article.dart';

class ArticleResponse {
 bool success;
 int errorCode;
 String message;

  List<Article> list;
 ArticleResponse({this.success,this.errorCode,this.message,this.list});

  factory ArticleResponse.fromJson(Map<String,dynamic> json){
    var list=json['items'] as List;
    var articles=list.map((item)=>
      Article.fromJson(item)
    ).toList();
    return ArticleResponse(
        success:json['success'],
        errorCode:(json['error_code'] is int)?json['error_code']:int.parse(json['error_code']),
        message:json['message'],
        list:articles);
  }

}