import 'package:flutter/material.dart';
import 'package:news/bean/short_video.dart';

class ShortVideoDetailPage extends StatefulWidget {
  final List<ShortVideo> videos;

  ShortVideoDetailPage({@required this.videos});

  @override
  State<StatefulWidget> createState() {
    return _ShortVideoDetailPageState(videos: videos);
  }
}

class _ShortVideoDetailPageState extends State<ShortVideoDetailPage> {
  final List<ShortVideo> videos;

  _ShortVideoDetailPageState({@required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          ShortVideo video = videos[position];
          return Stack(
            children: [
              Positioned.fill(
                  child: Image.network(
                    video.thumb_image.url,
                    fit: BoxFit.fill,
                  )),
              Positioned(bottom: 12, left: 15, right: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("@${video.media_info.name}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xfffffcf5),

                      ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,8,93,0),
                      child: Text(video.description,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xfffffcf5)
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                            color: Color(0x26ffffff),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Image.asset(
                                "assets/images/ic_short_video_comment.webp",
                                width: 15, height: 15,),
                            ),
                            Text(
                              "在此表达你的观点",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xfffffcf5)
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),),
              Positioned(
                  right: 12,
                  bottom: 80,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/thanos_icon_like_new_ui_normal.png",
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            video.support_count.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/thanos_icon_comment_new_ui_normal.png",
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            video.comment_count.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/thanos_icon_share_new_ui_normal.png",
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            video.share_count.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
      ),
    );
  }
}
