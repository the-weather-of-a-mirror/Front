import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
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
  runApp(MaterialApp(home:WhetherApp()));
}

List<Widget> viewList=[HomeScreen(),  MapScreen(),  WarningScreen(), LoginScreen()];

class WhetherApp extends StatefulWidget {
  @override
  _WhetherApp createState() => _WhetherApp();
}



class _WhetherApp extends State<WhetherApp> {

  int _currentIndex = 0;



void checkToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print(token);

 if (token != "") {
      viewList  = [HomeScreen(),  MapScreen(),  WarningScreen(), MyPageScreen()];
    }
    if (token == "" || token == null){
      viewList  = [HomeScreen(),  MapScreen(),  WarningScreen(), LoginScreen()];
    }

  setState(() {});

}


   
@override
Widget build(BuildContext context){


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
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
              child: Text('메뉴'),
              
            ),
           const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('마이페이지'),
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
              title: const Text('QrScanner'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=> Qrscanner()
                    )
                );
              },
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴2'),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴3'),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('메뉴4'),
            ),
          ],
        )
      ),
      
      body: TabBarView(children: viewList
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
            
            text: ("로그인")
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
