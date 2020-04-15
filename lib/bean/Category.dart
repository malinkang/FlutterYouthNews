import 'package:news/bean/BaseResponse.dart';

class Category extends BaseResponse{
  String name;

  Category(this.name);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['name']);
  }
}
