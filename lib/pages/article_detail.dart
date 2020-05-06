import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/bean/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

///CustomScrollView嵌套WebView Bug 所以不能使用CustomScrollView，也无法嵌套listview
///相关推荐和评论后续再做
///https://github.com/flutter/flutter/issues/31243
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ArticleDetailPage({
    @required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text(article.account_name,style: TextStyle(fontSize: 17,color: Color(0xff444444)),),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          ///返回按钮
          icon: Image.asset("assets/images/ic_article_back.png"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        ///https://flutter.dev/docs/catalog/samples/app-bar-bottom
        ///添加分割线
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 0.5,
            thickness: 0.5,
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),

      body:  WebView(
        ///将https换为http避免Mixed Content: The page at 错误
        initialUrl: article.url.replaceAll("https", "http"),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
