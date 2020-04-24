import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/ApiService.dart';
import 'package:news/bean/user_center_model.dart';

class UserCenterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserCenterPageState();
  }
}

Future<List<UserCenterModel>> future;

class _UserCenterPageState extends State<UserCenterPage> {
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    future = ApiService().getUserCenter();
  }

  var items = List<Widget>();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double height = (MediaQuery.of(context).size.width - 30) / 720 * 120;
    return Padding(
      padding: EdgeInsets.fromLTRB(15, statusBarHeight, 15, 0),
      child: FutureBuilder<List<UserCenterModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserCenterModel> models = snapshot.data;
            models.forEach((model) {
              var data = model.item_data;
              if (model.item_type == "header") {
                items.add(SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var item = model.item_data[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Image.network(item.image,
                                    width: 40, height: 40),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                        color: Color(0xff999999), fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      );
                    }, childCount: model.item_data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    )));
              } else if (model.item_type == "banner") {
                PageController controller = PageController();
                items.add(SliverToBoxAdapter(
                  child: Container(
                    height: height,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var item = data[index];
                            return Image.network(
                              item.image,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicator(
                            itemCount: data.length,
                            controller: controller,
                            onPageSelected: (int page) {
                              controller.animateToPage(
                                page,
                                duration: _kDuration,
                                curve: _kCurve,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              } else if (model.item_type == "app") {
                items.add(SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var item = model.item_data[index];
                      return Container(
                        child:  Stack(
                          children: [
                            Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.network(item.image,
                                          width: 40, height: 40),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Color(0xff999999), fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    }, childCount: model.item_data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    )));
              } else if (model.item_type == "system") {
                items.add(SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                      var item=  data[index];
                      Radius top;
                      Radius bottom;
                      if(index==0){
                        top = Radius.circular(5);
                        bottom = Radius.circular(0);
                      }else if(index==data.length-1){
                        top = Radius.circular(0);
                        bottom = Radius.circular(5);
                      }else{
                        top = Radius.circular(0);
                        bottom = Radius.circular(0);
                      }
                    return Container(
                      height: 48.5,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: top,bottom: bottom),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 5),
                            color: Color(0xffEDEDED),
                            blurRadius: 5.0,
                          )
                        ]
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 48,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(item.name,style: TextStyle(color: Color(0xff333333),fontSize: 15),),
                                Row(
                                  children: [
                                    Text(item.desc==null?"":item.desc,style: TextStyle(fontSize: 12),),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Image.asset("assets/images/ic_right_arrow.webp"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(height: 0.5,color: Color(0xFFEFF0F2),)
                        ],
                      ),
                    );
                  }, childCount: data.length),
                ));
              }
            });

            return CustomScrollView(
              slivers: items,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

///https://gist.github.com/collinjackson/4fddbfa2830ea3ac033e34622f278824
/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
