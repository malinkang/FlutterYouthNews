import 'package:news/bean/user_center_model.dart';

class UserCenterResponse {
  bool success;
  String errorCode;
  String message;

  List<UserCenterModel> list;
  UserCenterResponse({this.success,this.errorCode,this.message,this.list});

  factory UserCenterResponse.fromJson(Map<String,dynamic> json){
    var list=json['items'] as List;
    var articles=list.map((item)=>
        UserCenterModel.fromJson(item)
    ).toList();
    return UserCenterResponse(
        success:json['success'],
        errorCode: (json['error_code'] is String)? json['error_code']:json['error_code'].toString(),
        message:json['message'],
        list:articles);
  }

}