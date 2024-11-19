import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whether/QRScanner.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String name = '';
  String email = '';
  String city = '';
  bool isLoading = true;
  String? token = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // SharedPreferences에서 토큰을 읽어와서 서버로 GET 요청 보내기
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token'); // 토큰을 가져옵니다.

    if (token != null && token!.isNotEmpty) {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
          'GET', Uri.parse('http://223.195.109.34:8080/mirror/member/info'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonS = await response.stream.bytesToString();
        var data = json.decode(jsonS);
        setState(() {
          name = data['data']['name'];
          email = data['data']['email'];
          city = data['data']['area'];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        print('Error: ${response.statusCode}');
      }
    } else {
      setState(() => isLoading = false);
      print('No token found');
    }
  }

  // 토큰을 삭제하는 함수
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // 로그아웃 후 이전 화면으로 돌아가기
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 5),
                  Text(name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('이메일',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 5),
                  Text(email,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('지역',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 5),
                  Text(city,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text('로그아웃', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
