import 'package:news/bean/Article.dart';
import 'package:news/bean/short_video.dart';

class ShortVideoResponse {
 bool success;
 String errorCode;
 String message;

  List<ShortVideo> list;
 ShortVideoResponse({this.success,this.errorCode,this.message,this.list});

  factory ShortVideoResponse.fromJson(Map<String,dynamic> json){
    var list=json['items'] as List;
    var articles=list.map((item)=>
      ShortVideo.fromJson(item)
    ).toList();
    return ShortVideoResponse(
        success:json['success'],
        errorCode: (json['error_code'] is String)? json['error_code']:json['error_code'].toString(),
        message:json['message'],
        list:articles);
  }

}