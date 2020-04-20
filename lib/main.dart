import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/ApiService.dart';
import 'package:news/home.dart';
import 'package:news/LittleVideoPage.dart';
import 'package:news/ProfilePage.dart';
import 'package:news/TaskPage.dart';
import 'package:news/video.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    HomePage(),
    VideoPage(),
    ShortVideoPage(),
    TaskPage(),
    ProfilePage()
  ];
  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.webp',
        'assets/images/ic_tab_home_normal.webp'),
    _Item('视频', 'assets/images/ic_tab_video_active.webp',
        'assets/images/ic_tab_video_normal.webp'),
    _Item('小视频', 'assets/images/ic_tab_short_video_active.webp',
        'assets/images/ic_tab_short_video_normal.webp'),
    _Item('任务', 'assets/images/ic_tab_task_active.webp',
        'assets/images/ic_tab_task_normal.webp'),
    _Item('我的', 'assets/images/ic_tab_profile_active.webp',
        'assets/images/ic_tab_profile_normal.webp')
  ];
  int _selectedIndex = 0;

  Widget getPagesWidget(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: TickerMode(
        enabled: _selectedIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var list = itemNames
        .map((item) => {
              BottomNavigationBarItem(
                  title: Text(item.name, style: TextStyle(fontSize: 10.0)),
                  icon: Image.asset(item.normalIcon),
                  activeIcon: Image.asset(item.activeIcon))
            })
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: <Widget>[
          getPagesWidget(0),
          getPagesWidget(1),
          getPagesWidget(2),
          getPagesWidget(3),
          getPagesWidget(4),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: itemNames
            .map((item) => BottomNavigationBarItem(
                title: Text(item.name, style: TextStyle(fontSize: 12.0)),
                icon: Image.asset(item.normalIcon),
                activeIcon: Image.asset(item.activeIcon)))
            .toList(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff31c27c),
        onTap: _onItemTapped,
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
