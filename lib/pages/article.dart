import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:news/api.dart';
import 'package:news/bean/category.dart';

import 'article_list.dart';

///首页
class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticlePageState();
  }
}

class _ArticlePageState extends State<ArticlePage> with TickerProviderStateMixin {

  TabController controller;
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  Future<List<Category>> future;

  @override
  void initState() {
    super.initState();
    future = ApiService().getArticleCategory();
    getDeviceInfo();
    selectColor = Color(0xff262626);
    unselectedColor = Color(0xff828282);
    selectStyle = TextStyle(
        fontSize: 17, color: selectColor, fontWeight: FontWeight.bold);
    unselectedStyle = TextStyle(fontSize: 17, color: unselectedColor);
  }
  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('model= ${androidInfo.model}');
      print('brand= ${androidInfo.brand}');
      print('product= ${androidInfo.product}');
      print('device= ${androidInfo.device}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    }
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Category>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Category> items = snapshot.data;
          controller = TabController(length: items.length, vsync: this);
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TabBar(
                  indicatorWeight: 2,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                  indicatorColor: Color(0xff31c27c),
                  labelColor: selectColor,
                  labelStyle: selectStyle,
                  unselectedLabelColor: unselectedColor,
                  unselectedLabelStyle: unselectedStyle,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: controller,
                  tabs: items.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(item.name),
                    );
                  }).toList()),
              Expanded(
                child: TabBarView(
                    controller: controller,
                    children: items.map((item) {
                      return ArticleListPage(id: item.id);
                    }).toList()),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
