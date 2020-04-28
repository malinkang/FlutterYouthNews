import 'package:flutter/material.dart';
import 'package:news/api.dart';
import 'package:news/article_list.dart';
import 'package:news/bean/Category.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//  List<Category> items = List<Category>();
//  final List<String> list = ['影评', '话题', '讨论'];

  TabController controller;
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  Future<List<Category>> future;

  @override
  void initState() {
    super.initState();
    future = ApiService().getArticleCategory();
    selectColor = Color(0xff262626);
    unselectedColor = Color(0xff828282);
    selectStyle = TextStyle(
        fontSize: 17, color: selectColor, fontWeight: FontWeight.bold);
    unselectedStyle = TextStyle(fontSize: 17, color: unselectedColor);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Padding(
        padding: new EdgeInsets.only(top: statusBarHeight),
        child: FutureBuilder<List<Category>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> items = snapshot.data;

              controller = TabController(length: items.length, vsync: this);
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Divider(
                      color: Color(0xFFDDDDDD),
                      height: 0.5,
                    ),
                  ),
                  Column(
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
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
