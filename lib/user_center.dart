import 'dart:math';

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
      padding: EdgeInsets.only(top: statusBarHeight),
      child: FutureBuilder<List<UserCenterModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserCenterModel> models = snapshot.data;
            models.forEach((model) {
              if (model.item_type == "header"||model.item_type=="app") {
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
                                    Image.network(item.image, width: 40, height: 40),
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
                    },childCount: model.item_data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    )));
              } else if (model.item_type == "banner") {
                var data = model.item_data;
                PageController controller = PageController();
              items.add(SliverToBoxAdapter(child: Container(
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
              ),));
              } else if (model.item_type == "app") {
                var data = model.item_data;
                items.add(SliverToBoxAdapter(child: Column(
                  children: [
                    Text(model.item_title),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          var item = data[index];
                          return Column(
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
                          );
                        })
                  ],
                ),));
              } else if (model.item_type == "system") {
                var data = model.item_data;
                items.add(SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Text(data[index].name);
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
