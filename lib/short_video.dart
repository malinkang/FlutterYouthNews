import 'package:flutter/material.dart';
import 'package:news/ApiService.dart';
import 'package:news/bean/Article.dart';
import 'package:news/bean/short_video.dart';

import 'FeedDetailPage.dart';

class ShortVideoListPage extends StatefulWidget {
  String id; //分类id
  ShortVideoListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _ShortVideoListPagePageState(id: id);
  }
}

abstract class ListItem {}

class _ShortVideoListPagePageState extends State<ShortVideoListPage> {
  ScrollController _scrollController;
  List<ShortVideo> items = List<ShortVideo>();
  String id; //
  Future<List<Article>> futureArticle;

  _ShortVideoListPagePageState({this.id});

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
    return ApiService().getShortVideo(0, "-1", "10").then((data) {
      setState(() => this.items.addAll(data));
    });
  }

  Future<dynamic> _onLoadmore() {
    return ApiService().getShortVideo(0, "-1", "10").then((data) {
      setState(() {
        this.items.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double smallWidth = MediaQuery.of(context).size.width;
    double smallHeight = smallWidth * 326 / 580;
    print("build ${items.length}");
    return RefreshIndicator(
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            ShortVideo video = items[index];
             if (index == items.length - 1) {
              return _loadMoreWidget();
            } else {
              return Container(
                margin:
                EdgeInsets.fromLTRB(0, 0, (index % 2 == 0) ? 0.5 : 0, 0.5),
                height: 290,
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff7c7c7c)),
                child: Stack(
                  children: [
                    Image.network(
                      video.thumb_image.url,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 290,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.title,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            maxLines: 2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/ic_home_video_play.png"),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        "${video.play_count}次播放",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                Text("${video.support_count}赞",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
        onRefresh: _onRefresh);
  }

}
