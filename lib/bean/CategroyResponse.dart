import 'package:news/bean/Category.dart';

class CategroyResponse {
 bool success;
 String errorCode;
 String message;

  List<Category> list;
  CategroyResponse({this.success,this.errorCode,this.message,this.list});

  factory CategroyResponse.fromJson(Map<String,dynamic> json){
    var list=json['items'] as List;
    var categories=list.map((item)=>
      Category.fromJson(item)
    ).toList();
    return CategroyResponse(
        success:json['success'],
        errorCode:json['error_code'],
        message:json['message'],
        list:categories);
  }

}