import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:news/bean/article.dart';
import 'package:video_player/video_player.dart';

import 'api.dart';

class VideoDetailPage extends StatefulWidget {
  final Article article;

  VideoDetailPage({@required this.article});

  @override
  _VideoDetailPageState createState() =>
      _VideoDetailPageState(article: article);
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  List<Article> articles = new List();
  Article article;

  _VideoDetailPageState({this.article});

  Future<dynamic> getRelateArticle() {
    articles.clear();
    return ApiService().getRelateArticle(article.id).then((data) {
      setState(() => data.forEach((article) {
        if(article.title!=null&&article.title.isNotEmpty){ //排除广告
          articles.add(article);
        }
      }));
    });
  }

  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    _controller = VideoPlayerController.network(
      article.video_play_url,
    );
    getRelateArticle();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double smallWidth = (screenWidth - 30 - 8) / 3;
    double smallHeight = smallWidth * 141 / 216;
    var videoWidth = article.video_width;
    var videoHeight = article.video_height;
    var aspectRatio =
        ((videoWidth > 0 && videoHeight > 0 && videoHeight > videoWidth)
            ? screenWidth / (screenHeight * 2 / 3)
            : (screenWidth / 200)); //不是长视频高度写死
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: aspectRatio,
      autoPlay: true,
      looping: true,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              Article article = articles[index];
              print("title ${article.title}");
              return GestureDetector(
                  child: IntrinsicHeight(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  article.title,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff323232),decoration: TextDecoration.none),
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            VideoDetailPage(article: article))),
                  });
            }, childCount: articles.length),
          )
        ],
      ),
    );
  }
}
