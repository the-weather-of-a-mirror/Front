import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String name = '';
  String email = '';
  String city = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // SharedPreferences에서 토큰을 읽어와서 서버로 GET 요청 보내기
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // 토큰을 가져옵니다.

    if (token != null) {
      // 토큰이 있을 경우 GET 요청을 보냅니다.
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
          'GET', Uri.parse('http://223.195.109.34:8080/mirror/member/info'));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonS = await response.stream.bytesToString();
        var data = json.decode(jsonS);
        setState(() {
          name = data['data']['name'];
          email = data['data']['email'];
          city = data['data']['area'];
          isLoading = false; // 데이터 로드가 완료되면 isLoading을 false로 설정
        });
      } else {
        // 오류 처리
        setState(() {
          isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('No token found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 중에는 로딩 인디케이터 표시
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름: $name', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('이메일: $email', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('지역: $city', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
    );
  }
}
