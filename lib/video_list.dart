import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/api.dart';
import 'package:news/bean/article.dart';
import 'package:news/video_detail.dart';

///视频列表页
class VideoListPage extends StatefulWidget {
  final String id; //分类id
  VideoListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _VideoListPageState(id: id);
  }
}

abstract class ListItem {}

class _VideoListPageState extends State<VideoListPage> {
  ScrollController _scrollController;
  List<Article> items = List<Article>();
  bool isLoadingMore = false; //加载更多
  String id; //
  Future<List<Article>> futureArticle;

  _VideoListPageState({this.id});

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
        .getArticle("1453", 0, "-1", "-1", "-1", id)
        .then((data) {
      setState(() => this.items.addAll(data));
    });
  }

  void _onLoadmore() {
    setState(() {
      isLoadingMore = true;
    });

    ///延迟500ms
    Future.delayed(const Duration(milliseconds: 500), () {
      ApiService().getArticle("1453", 0, "-1", "-1", "-1", id).then((data) {
        setState(() {
          this.items.addAll(data);
          isLoadingMore = false;
        });
      }).catchError((error) {
        setState(() {
          Fluttertoast.showToast(msg: "获取失败", gravity: ToastGravity.CENTER);
          isLoadingMore = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double smallWidth = MediaQuery.of(context).size.width;
    double smallHeight = smallWidth * 326 / 580;
    return RefreshIndicator(

        ///https://github.com/flutter/flutter/issues/14842
        ///移除listview上的padding
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: isLoadingMore ? (items.length + 1) : items.length,
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return _loadMoreWidget();
                } else {
                  Article article = items[index];
                  return GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.network(article.thumb,
                                width: smallWidth, height: smallHeight),
                            Container(
                              //标题
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                      "assets/images/video_nav_bg.png"),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                child: Text(
                                  article.title + '\n',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Image.asset(
                                    "assets/images/video_icon.webp")),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                decoration: BoxDecoration(
                                    color: Color(0xff000000),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Text(
                                  article.video_time,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/play1_icon.webp"),
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      "${article.read_num}次播放",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff999999)),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/comments_icon.webp"),
                                  Container(
                                    margin: EdgeInsets.only(left: 30),
                                    child: Image.asset(
                                        "assets/images/video_more_icon.webp"),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoDetailPage(article: article))),
                    },
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Color(0xFFEEEEEC),
                  height: 6,
                  thickness: 6,
                );
              },
            )),
        onRefresh: _onRefresh);
  }
}
