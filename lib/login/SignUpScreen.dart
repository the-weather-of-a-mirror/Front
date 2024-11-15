import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:whether/main.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 이메일, 비밀번호, 이름 등 변수 선언
  String id = '', password = '', name = '', email = '', city = '';
  String _selectedCities = '서울';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<String> _CitiesList = [
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '경기',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이디 입력 필드
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => id = text, // 아이디 변수에 저장
            ),

            SizedBox(height: 16),
            // 비밀번호 입력 필드
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (text) => password = text, // 비밀번호 변수에 저장
            ),

            SizedBox(height: 16),
            // 이름 입력 필드
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => name = text, // 이름 변수에 저장
            ),

            SizedBox(height: 16),
            // 이메일 입력 필드
            TextField(
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                setState(() {
                  email = text; // 이메일 변수에 저장
                });
              },
            ),

            SizedBox(height: 16),
            // 지역 선택 드롭다운
            DropdownButtonFormField<String>(
              value: _selectedCities,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCities = newValue!; // 선택된 도시 변수에 저장
                  city = "SEOU";
                  city = _mapCityToCode(_selectedCities); // 도시 코드 매핑
                });
              },
              items: _CitiesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: '지역',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),
            // 회원가입 버튼
            ElevatedButton(
              onPressed: () async {
                // 회원가입 버튼 눌렀을 때의 로직 추가
                var headers = {'Content-Type': 'application/json'};
                var request = http.Request(
                    'POST',
                    Uri.parse(
                        'http://223.195.109.34:8080/mirror/member/signup'));
                request.body = json.encode({
                  "loginId": id,
                  "password": password,
                  "name": name,
                  "email": email,
                  "area": city,
                });
                request.headers.addAll(headers);

                debugPrint('이것은 : ' + request.body);

                http.StreamedResponse response = await request.send();

                var jsonS = await response.stream.bytesToString();
                var jsonData = json.decode(jsonS);
                var error = '';

                if (response.statusCode == 200) {
                  var signUpDone = jsonData['message'];
                  print(signUpDone);
                  Navigator.pop(context);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text(signUpDone),
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
                } else if (response.statusCode == 400) {
                  if (jsonData['data']['ERROR'] != null) {
                    error = jsonData['data']['ERROR'];
                  } else if (jsonData['data']['_password'] != null) {
                    error = jsonData['data']['_password'];
                  } else if (jsonData['data']['_name'] != null) {
                    error = jsonData['data']['_name'];
                  } else if (jsonData['data']['_email'] != null) {
                    error = jsonData['data']['_email'];
                  }
                  print(jsonData['data']);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text(error),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, '확인'),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }

  // 도시를 코드로 변환하는 함수
  String _mapCityToCode(String cityName) {
    switch (cityName) {
      case '서울':
        return 'SEOU';
      case '부산':
        return 'BUSA';
      case '대구':
        return 'DAEG';
      case '인천':
        return 'INCH';
      case '광주':
        return 'GWAN';
      case '대전':
        return 'DAEJ';
      case '울산':
        return 'ULSA';
      case '세종':
        return 'SEJO';
      case '경기':
        return 'GYEO';
      case '강원':
        return 'GANG';
      case '충북':
        return 'CHUB';
      case '충남':
        return 'CHUN';
      case '전북':
        return 'JEOB';
      case '전남':
        return 'JEON';
      case '경북':
        return 'GYUB';
      case '경남':
        return 'GYUN';
      case '제주':
        return 'JEJU';
      default:
        return ''; // 기본값 설정
    }
  }
}
