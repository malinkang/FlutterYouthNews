import 'package:flutter/material.dart';
import 'package:news/api.dart';
import 'package:news/bean/article.dart';

import 'article_detail.dart';

class ArticleListPage extends StatefulWidget {
  final String id; //分类id
  ArticleListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _ArticleListPageState(id: id);
  }
}

abstract class ListItem {}

class _ArticleListPageState extends State<ArticleListPage> {
  ScrollController _scrollController;
  List<Article> items = List<Article>();
  String id; //
  Future<List<Article>> futureArticle;
  bool isLoadingMore = false; //加载更多

  _ArticleListPageState({this.id});

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onLoadmore();
      }
    });
  }

  Widget _loadMoreWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
            width: 20,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "努力加载中...",
              style: TextStyle(fontSize: 15, color: Color(0xFF7D868D)),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> _onRefresh() {
    items.clear();
    return ApiService()
        .getArticle(id, 0, "-1", "-1", "-1", "1453")
        .then((data) {
      setState(() => this.items.addAll(data));
    });
  }

  Future<dynamic> _onLoadmore() {
    setState(() {
      isLoadingMore = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      ApiService()
          .getArticle(id, 0, "-1", "-1", "-1", "1453")
          .then((data) {
        setState(() {
          this.items.addAll(data);
          isLoadingMore = false;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    //小图宽 屏幕宽度-两边边距30-图片之间的padding8
    double smallWidth = (MediaQuery.of(context).size.width - 30 - 8) / 3;
    double smallHeight = smallWidth * 141 / 216;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0), //设置两边边距
      child: RefreshIndicator(
          child: MediaQuery.removePadding(context: context,removeTop: true, child: ListView.separated(
            controller: _scrollController,
            itemCount: isLoadingMore ? (items.length + 1) : items.length,
            itemBuilder: (context, index) {
              if (index == items.length) {
                return _loadMoreWidget();
              } else {
                Article article = items[index];
                if (article.image_type == '0') {
                  //无图
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //标题居左
                        children: <Widget>[
                          Text(
                            article.title,
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff323232)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(article.account_name,
                                        style: TextStyle(
                                            color: Color(0xffc0c0c0),
                                            fontSize: 10)),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text("${article.read_num}阅读",
                                          style: TextStyle(
                                              color: Color(0xffc0c0c0),
                                              fontSize: 10)),
                                    )
                                  ],
                                ),
                                Text("1分钟前",
                                    style: TextStyle(
                                        color: Color(0xffc0c0c0), fontSize: 10))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FeedDetailPage(
                           article: article))),
                    },
                  );
                } else if (article.image_type == '1') {
                  //小图
                  return GestureDetector(
                      child: IntrinsicHeight(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      article.title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff323232)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(article.account_name,
                                                  style: TextStyle(
                                                      color: Color(0xffc0c0c0),
                                                      fontSize: 10)),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                                child: Text(
                                                    "${article.read_num}阅读",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xffc0c0c0),
                                                        fontSize: 10)),
                                              )
                                            ],
                                          ),
                                          Text("1分钟前",
                                              style: TextStyle(
                                                  color: Color(0xffc0c0c0),
                                                  fontSize: 10))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Image.network(
                                  article.thumb,
                                  width: smallWidth,
                                  height: smallHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FeedDetailPage(
                               article: article,))),
                      });
                } else if (article.image_type == '2') {
                  //多图
                  return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, //标题居左
                          children: <Widget>[
                            //标题
                            Text(
                              article.title,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff323232)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(article.account_name,
                                          style: TextStyle(
                                              color: Color(0xffc0c0c0),
                                              fontSize: 10)),
                                      Container(
                                        margin:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text("${article.read_num}阅读",
                                            style: TextStyle(
                                                color: Color(0xffc0c0c0),
                                                fontSize: 10)),
                                      )
                                    ],
                                  ),
                                  Text("1分钟前",
                                      style: TextStyle(
                                          color: Color(0xffc0c0c0),
                                          fontSize: 10))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FeedDetailPage(
                                article: article,))),
                      });
                } else {
                  //大图
                  return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                article.title,
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff323232)),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FeedDetailPage(
                                article: article,))),
                      });
                }
              }
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Color(0xFFE5E5E5),
                height: 0.5,
              );
            },
          )),
          onRefresh: _onRefresh),
    );
  }
}
