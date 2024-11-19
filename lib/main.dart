import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whether/WarningScreen/SaveTool.dart';
import 'package:whether/WarningScreen/ShelterInfo.dart';
import 'package:whether/login/LoginScreen.dart';
import 'package:whether/login/MyPageScreen.dart';
import 'QRScanner.dart';
import 'WhatScreen.dart';
import 'WarningScreen/WarningScreen.dart';
import 'MapScreen.dart';
import 'HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';

void main() {
  runApp(MaterialApp(home: WhetherApp()));
}

List<Widget> viewList = [
  HomeScreen(),
  MapScreen(),
  WarningScreen(),
  LoginScreen()
];

String loginTab = "로그인";

class WhetherApp extends StatefulWidget {
  @override
  _WhetherApp createState() => _WhetherApp();
}

class _WhetherApp extends State<WhetherApp> {
  int _currentIndex = 0;

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print(token);

    if (token != "") {
      viewList = [HomeScreen(), MapScreen(), WarningScreen(), MyPageScreen()];
      loginTab = "마이 페이지";
    }
    if (token == "" || token == null) {
      viewList = [HomeScreen(), MapScreen(), WarningScreen(), LoginScreen()];
      loginTab = "로그인";
    }

    setState(() {});
  }


  void checkQR() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Qrscanner()));
     
    }
    else if (token == "" || token == null) {
    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text("로그인을 해주세요."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            
                          },
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );

    }
    print(token);
    setState(() {
      
    });

  }

  @override
  Widget build(BuildContext context) {
    checkToken();

    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text('거울의 날씨'),
            centerTitle: true,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ), //메뉴 버튼
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ), // 검색 버튼
            ]),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
              child: Text('메뉴',
              style: TextStyle(color:Colors.white),),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('재난문자'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: const Text('거울 등록'),
              onTap: () {
                checkQR();
              
              },
            ),
          ],
        )),
        body: TabBarView(children: viewList),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Container(
            color: Colors.white,
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 10, top: 5),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.black,
                  indicatorWeight: 2,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 13,
                  ),
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: ("메인")),
                    Tab(icon: Icon(Icons.search), text: ("지도")),
                    Tab(icon: Icon(Icons.comment), text: ("재난대처")),
                    Tab(icon: Icon(Icons.star), text: (loginTab)),
                  ]),
            )),
      ),
    ));
  }
}

final controller = PageController(
  initialPage: 1,
);

final pageView = PageView();
