import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whether/Key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShelterInfo extends StatefulWidget {
  @override
  _ShelterInfoState createState() => _ShelterInfoState();
}

class _ShelterInfoState extends State<ShelterInfo> {
  List<Map<String, dynamic>> shelters = []; // 대피소 데이터 리스트
  bool isLoading = true; // 로딩 상태 플래그

  @override
  void initState() {
    super.initState();
    getShelter(); // 초기 데이터 로드
  }

  Future<void> getShelter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');


    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'X-API-Key': ApiKeys.shelterApiKey};
        var request = http.Request('GET',
        Uri.parse('http://223.195.109.34:8080/mirror/weather/shelter'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonS = await response.stream.bytesToString();
        var jsonData = json.decode(jsonS);

        // JSON 데이터 파싱
        List<dynamic> body = jsonData['data']['body'];
        setState(() {
          shelters = body.map((item) {
            return {
              'name': item['REARE_NM'] ?? '알 수 없음',
              'address': item['RONA_DADDR'] ?? '주소 없음',
              'type': item['SHLT_SE_NM'] ?? '정보 없음',
            };
          }).toList();
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
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
        title: Text('대피소 정보'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 상태 표시
          : ListView.builder(
              itemCount: shelters.length,
              itemBuilder: (context, index) {
                final shelter = shelters[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shelter['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('주소: ${shelter['address']}'),
                        SizedBox(height: 8),
                        Text('유형: ${shelter['type']}'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
