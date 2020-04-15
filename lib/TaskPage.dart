import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }

}

class _TaskPageState extends State<TaskPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("任务中心",style: TextStyle(fontSize: 20,color: Colors.blueAccent),),
      ),
    );
  }

}
