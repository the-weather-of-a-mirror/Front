import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUpScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

void saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('auth_token', token); // 토큰을 SharedPreferences에 저장
}

void kk() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print(token);
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var id='';
  var password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                setState(() {
                  id = text; // 이메일 변수에 저장
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  password = text; // 이메일 변수에 저장
                });
              },
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var headers = {'Content-Type': 'application/json'};
                var request = http.Request('POST',
                    Uri.parse('http://223.195.109.34:8080/mirror/member/login'));
                request.body = json
                    .encode({"loginId": id, "password": password});
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();
                
                var jsonS = await response.stream.bytesToString();
                var jsonData = json.decode(jsonS);


                if (response.statusCode == 200) {
                  print(jsonData);
                  saveToken(jsonData['data']['accessToken']);
                  
                } else {
                  print(response.reasonPhrase);
                }

                print('로그인 버튼 클릭됨');
                kk();
              },
              child: Text('로그인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
