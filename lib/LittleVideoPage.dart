import 'package:flutter/material.dart';

class ShortVideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ShortVideoPageState();
  }

}

class _ShortVideoPageState extends State<ShortVideoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("小视频",style: TextStyle(fontSize: 20,color: Colors.blueAccent),),
      ),
    );
  }

}
