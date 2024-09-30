import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

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
      ),body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex,
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
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Text('메인 화면',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
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