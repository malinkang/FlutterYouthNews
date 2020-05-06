import 'package:flutter/material.dart';
import 'package:news/api.dart';
import 'package:news/bean/article.dart';
import 'package:news/bean/short_video.dart';
import 'package:news/pages/short_video_detail.dart';

class ShortVideoListPage extends StatefulWidget {
  final String id; //分类id
  ShortVideoListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _ShortVideoListPageState(id: id);
  }
}

class _ShortVideoListPageState extends State<ShortVideoListPage> {
  ScrollController _scrollController;
  List<ShortVideo> items = List<ShortVideo>();
  String id; //
  Future<List<Article>> futureArticle;
  bool isLoadingMore = false; //加载更多

  _ShortVideoListPageState({this.id});

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
    setState(() {
      isLoadingMore = true;
    });
    return Future.delayed(const Duration(milliseconds: 500), () {
      ApiService().getShortVideo(0, "-1", "10").then((data) {
        setState(() {
          this.items.addAll(data);
          isLoadingMore= false;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
        child: MediaQuery.removeViewPadding(
            context: context,
            removeTop: true,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context,index){
                    ShortVideo video = items[index];
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xff7c7c7c)), //设置背景
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Image.network(
                                  video.thumb_image.url,
                                  fit: BoxFit.cover,
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.title,
                                    style:
                                    TextStyle(fontSize: 16, color: Colors.white),
                                    maxLines: 2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                    fontSize: 11,
                                                    color: Colors.white),
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
                      ),
                      onTap: ()=>{
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShortVideoDetailPage(
                              videos: items,))),
                      },
                    );
                },childCount: items.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (width - 0.5) / 2 / 290,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 0.5),
                ),
                SliverToBoxAdapter(child: Offstage(
                  offstage: !isLoadingMore,
                  child: _loadMoreWidget(),
                ),)
              ],
            )),
        onRefresh: _onRefresh);
  }
}
