import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> forecasts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String changeString(String type){
    switch (type){
      case "PTY" : return "강수 형태";
      case "REH" : return "습도";
      case "RN1" : return "강수량";
      case "T1H" : return "기온";
      case "UUU" : return "동서바람성분";
      case "VEC" : return "풍향";
      case "VVV" : return "남북바람성분";
      case "WSD" : return "풍속";

    }
    return "l";
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var headers = {
      'Authorization': 'Bearer $token',
      'X-API-Key': 'wIWoiWwnQSmFqIlsJ7EpVA'
    };

    var request = http.Request('GET',
        Uri.parse('http://223.195.109.34:8080/mirror/weather/shortTerm'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonS = await response.stream.bytesToString();
      var jsonData = json.decode(jsonS);

      print("Full JSON Response: $jsonData");

      List<dynamic> items =
          jsonData['data']?['response']?['body']?['items']?['item'] ?? [];

      setState(() {
        forecasts = items.map((item) {
          return {
            'date': item['baseDate'] ?? '알 수 없음',
            'type': item['category'] ?? '알 수 없음',
            'nx': item['nx']?.toString() ?? '알 수 없음',
            'ny': item['ny']?.toString() ?? '알 수 없음',
            'obsrValue': item['obsrValue']?.toString() ?? '알 수 없음',
          };
        }).toList();
        isLoading = false;
      });
    } else {
      print("Request failed with status: ${response.statusCode}");
      print("Reason: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
  title: Text(
    forecasts.isNotEmpty
        ? "${forecasts[0]['date']} 예보"
        : "예보 데이터 없음", // 리스트가 비어있을 때 표시할 기본 텍스트
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.black,
),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : forecasts.isEmpty
              ? Center(
                  child: Text(
                    '데이터가 없습니다.',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: forecasts.length,
                  itemBuilder: (context, index) {
                    final forecast = forecasts[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${changeString(forecast['type'])} : ${forecast['obsrValue']}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
