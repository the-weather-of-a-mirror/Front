import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whether/Key.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<Map<String, dynamic>> messages = []; // 대피소 데이터 리스트
  bool isLoading = true; // 로딩 상태 플래그
  String? token = '';

  @override
  void initState() {
    super.initState();
    getMessage(); // 초기 데이터 로드
  }

  Future<void> getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token'); // 토큰을 가져옵니다.
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'X-API-Key': ApiKeys.messageApiKey
      };
      var request = http.Request('GET',
          Uri.parse('http://223.195.109.34:8080/mirror/weather/disasterMsg'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonS = await response.stream.bytesToString();
        var jsonData = json.decode(jsonS);

        // JSON 데이터 파싱
        List<dynamic> body = jsonData['data']['body'];
        setState(() {
          messages = body.map((item) {
            return {
              'msg': item['MSG_CN'] ?? '메시지 없음',
              'region': item['RCPTN_RGN_NM'] ?? '지역 정보 없음',
              'date': item['CRT_DT'] ?? '날짜 정보 없음',
              'type': item['EMRG_STEP_NM'] ?? '유형 정보 없음',
            };
          }).toList();
          isLoading = false;
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("에러 발생: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], 
      appBar: AppBar(
        title: Text('재난 문자'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 상태 표시
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['msg'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(message['type']),
                        SizedBox(height: 8),
                        Text(message['region']),
                        SizedBox(height: 8),
                        Text(message['date'])
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
