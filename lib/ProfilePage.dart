import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }

}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("我的",style: TextStyle(fontSize: 20,color: Colors.blueAccent),),
      ),
    );
  }

}
