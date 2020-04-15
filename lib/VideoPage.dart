import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _VideoPageState();
  }

}

class _VideoPageState extends State<VideoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("视频",style: TextStyle(fontSize: 20,color: Colors.blueAccent),),
      ),
    );
  }

}
