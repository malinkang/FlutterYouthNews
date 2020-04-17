import 'package:flutter/material.dart';
import 'package:news/ApiService.dart';
import 'package:news/FeedListPage.dart';
import 'package:news/bean/Category.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage> {
  Future<List<Category>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = ApiService().getArticleCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<List<Category>>(
          future: futureCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DefaultTabController(
                length: snapshot.data.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("信息流"),
                    bottom: TabBar(
                        labelColor: Colors.white,
                        isScrollable: true,
                        tabs: snapshot.data.map((item) {
                      return Tab(text: item.name);
                    }).toList()),
                  ),
                  body: TabBarView(
                    children: snapshot.data.map((item) {
                      return FeedListPage(id:item.id);
                    }).toList(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
