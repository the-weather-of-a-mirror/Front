import 'dart:ffi';

import 'package:flutter/material.dart';

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
    WhatScreen()
  ];

@override
Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
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
      
      body: pageView,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      },
      
       items: const [

    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '메인',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '지도'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.comment),
      label: '재난대처'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: '여기다 뭐하지'
          ),
        ],
       )
      ),
    );
  }
}

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body:  
      
       Container(
           color: Colors.yellow,
           width: 1000,
           child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  width: 1000,
                  child: 
                Container(
          
              margin: EdgeInsets.only(top: 190,bottom: 190),
         
            child: const Text('2024-10-09\n화성시 봉담읍\n날씨 맑음, 미세먼지 좋음',
           
             textAlign: TextAlign.center),
            ),
                ),
            Container(
              color : Colors.green,
              width: 10000,
              height: 189.6,
              child:   
            Container(            
              child: Text('10월 재난정보\n1~10월 가뭄 예보\n10~20일 태풍 예보\n20일~30일 장마 예보',
               textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 50),
              height:80,
                        
              ),
            ),
              ],
            ),
            
           ),
           
      
      
      
    );    
  }
}

class MapScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Text('지도',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class WarningScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text('재난 대처 정보',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class WhatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text('여기다 뭐하지',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
        ),
      ),
    );
  }
}

final controller = PageController(
initialPage: 1,
);

final pageView = PageView(
  controller: controller,
  children: [
    HomeScreen(),
    MapScreen(),
    WarningScreen(),
    WhatScreen(),
  ],
);
