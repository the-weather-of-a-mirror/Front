import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whether/WarningScreen/SaveTool.dart';
import 'package:whether/WarningScreen/ShelterInfo.dart';
import 'WhatScreen.dart';
import 'WarningScreen/WarningScreen.dart';
import 'MapScreen.dart';
import 'HomeScreen.dart';


void main() {
  runApp(WhetherApp());
}

class WhetherApp extends StatefulWidget {
  @override
  _WhetherApp createState() => _WhetherApp();
}

class _WhetherApp extends State<WhetherApp> {

  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    WarningScreen(),
    WhatScreen(),
    ShelterInfo()
  ];

@override
Widget build(BuildContext context){
  return MaterialApp(
    home: DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
        title: Text('거울의 날씨'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
               icon: Icon(Icons.menu),
              onPressed: () {
              Scaffold.of(context).openDrawer();
            },);
          }, 
          ), //메뉴 버튼
          actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ), // 검색 버튼
          ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
              child: Text('메뉴'),
              
            ),
           ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('마이페이지'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('재난문자'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴1'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴2'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴3'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴4'),
            ),
          ],
        )
      ),
      
      body: TabBarView(children:[
        HomeScreen(),
        MapScreen(),
        WarningScreen(),
        WhatScreen(),
        ]
        ),
        extendBodyBehindAppBar: true,
        
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          height: 70,
          padding: EdgeInsets.only(bottom: 10,top:5),
          child: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            indicatorWeight: 2,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 13,
            ),
            tabs: [
            Tab(
              icon: Icon(Icons.home),
            
            text: ("메인")
            ),
            Tab(
              icon: Icon(Icons.search),
            
            text: ("지도")
            ),
            Tab(
              icon: Icon(Icons.comment),
            
            text: ("재난대처")
            ),
            Tab(
              icon: Icon(Icons.star),
            
            text: ("기타")
            ),
          ]),
        )
      ),
      ),
    )
    );
  }
}







final controller = PageController(
initialPage: 1,
);

final pageView = PageView(
  
);
