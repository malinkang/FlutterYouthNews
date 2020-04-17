import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/ApiService.dart';
import 'package:news/bean/Article.dart';

class FeedListPage extends StatefulWidget {
  String id; //分类id
  FeedListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _FeedListPageState(id: id);
  }
}

abstract class ListItem {}

class _FeedListPageState extends State<FeedListPage> {
  String id; //
  Future<List<Article>> futureArticle;

  _FeedListPageState({this.id});

  @override
  void initState() {
    super.initState();
    futureArticle = ApiService().getArticle(id, 0, "-1", "-1", "-1", "1453");
  }

  @override
  Widget build(BuildContext context) {
    //小图宽 屏幕宽度-两边边距30-图片之间的padding8
    double smallWidth = (MediaQuery.of(context).size.width - 30 - 8) / 3;
    double smallHeight = smallWidth * 141 / 216;
    print("屏幕宽 ${MediaQuery.of(context).size.width}");
    print("屏幕高 ${MediaQuery.of(context).size.height}");
    return FutureBuilder<List<Article>>(
        future: futureArticle,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Article article = snapshot.data[index];
                  if (snapshot.data[index].image_type == '0') {
                    //无图
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              snapshot.data[index].title,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff323232)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.data[index].image_type == '1') {
                    //小图
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff323232)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child:  Image.network(
                              article.thumb,
                              width: smallWidth,
                              height: smallHeight,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.data[index].image_type == '2') {
                    //多图
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start, //标题居左
                        children: <Widget>[
                          //标题
                          Text(
                            snapshot.data[index].title,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff323232)),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.network(article.extra[0],
                                    width: smallWidth, height: smallHeight),
                                Image.network(article.extra[1],
                                    width: smallWidth, height: smallHeight),
                                Image.network(article.extra[2],
                                    width: smallWidth, height: smallHeight),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(article.account_name,style: TextStyle(color: Color(0xffc0c0c0),fontSize: 10)),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child:  Text("${article.read_num}阅读",style: TextStyle(color: Color(0xffc0c0c0),fontSize: 10)),
                                    )
                                  ],
                                ),
                                Text("1分钟前",style: TextStyle(color: Color(0xffc0c0c0),fontSize: 10))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    //大图
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              snapshot.data[index].title,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff323232)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Color(0xFFE5E5E5),
                    height: 0.5,
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
