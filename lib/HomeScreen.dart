import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whether/Key.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> forecasts = [];
  bool isLoading = true;
  String city = '000';
  String specialData = "";
   Map<String, String>? specialAlert; // 특보 데이터를 저장할 상태 변수

  @override
  void initState() {
    super.initState();
    fetchData();
    getCity();
    getSpecial();
  }

  String changeCode(String type) {
    switch (type) {
      case "PTY":
        return "강수 형태";
      case "REH":
        return "습도";
      case "RN1":
        return "강수량";
      case "T1H":
        return "기온";
      case "UUU":
        return "동서바람성분";
      case "VEC":
        return "풍향";
      case "VVV":
        return "남북바람성분";
      case "WSD":
        return "풍속";
    }
    return "l";
  }

  String convertWindDirection(String vec) {
    if (vec == '알 수 없음') return vec; // 값이 알 수 없을 경우 그대로 반환

    double angle = double.tryParse(vec) ?? -1; // 숫자로 변환 실패 시 -1 반환
    if (angle < 0) return "알 수 없음";

    const directions = ["북", "북동", "동", "남동", "남", "남서", "서", "북서"];
    int index = ((angle + 22.5) ~/ 45.0) % 8; // 45도로 나눠 8방위로 분류
    return directions[index];
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var headers = {
      'Authorization': 'Bearer $token',
      'X-API-Key': ApiKeys.forecastApiKey
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

  Future<void> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('http://223.195.109.34:8080/mirror/member/info'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonS = await response.stream.bytesToString();
      var data = json.decode(jsonS);
      setState(() {
        city = data['data']['area'];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> getSpecial() async {
    var request = http.Request('GET',
        Uri.parse('http://223.195.109.34:8080/mirror/weather/specialReport'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      specialData = await response.stream.bytesToString();
      cutData();
    } else {
      print(response.reasonPhrase);
    }
  }

  void cutData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? area = prefs.getString('area');

    List<String> rows =
        specialData.split("\n").where((line) => line.isNotEmpty).toList();

    rows.removeWhere((line) => line.startsWith('#') || line.trim().isEmpty);

    List<Map<String, String>> parsedData = [];

    for (String row in rows) {
      List<String> fields = row.split(",").map((e) => e.trim()).toList();

      if (fields[1] == area || fields[3] == area || fields[9].isNotEmpty) {
        parsedData.add({
          "REG_UP_KO": fields[1],
          "WRN": fields[6],
          "LVL": fields[7],
          "CMD": fields[8],
          "ED_TM": fields[9],
        });
        var specialString = parsedData[0];

         setState(() {
          specialAlert = parsedData[0]; // 특보 데이터를 상태 변수에 저장
        });

        print("특보\n${specialString["WRN"]}${specialString["LVL"]}\n${specialString["ED_TM"]}");
        
      }
      if(parsedData.isNotEmpty)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          forecasts.isNotEmpty
              ? "${forecasts[0]['date']} $city 예보"
              : "예보 데이터 없음",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (specialAlert != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.red[100],
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "특보 정보",
                              style: TextStyle(
                                  
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800]),
                                  
                            ),

                            SizedBox(height: 8),
                            Text(
                              "경고: ${specialAlert?["WRN"] ?? "N/A"}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "레벨: ${specialAlert?["LVL"] ?? "N/A"}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "종료 시간: ${specialAlert?["ED_TM"] ?? "N/A"}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: forecasts.isEmpty
                      ? Center(
                          child: Text(
                            '데이터가 없습니다.',
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            final filteredForecasts =
                                forecasts.where((forecast) {
                              return forecast['type'] != "PTY" &&
                                  forecast['type'] != "UUU" &&
                                  forecast['type'] != "VVV";
                            }).toList();

                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: filteredForecasts.map((forecast) {
                                    String displayValue;
                                    if (forecast['type'] == 'VEC') {
                                      displayValue = convertWindDirection(
                                          forecast['obsrValue']);
                                    } else {
                                      displayValue = forecast['obsrValue'];
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        "${changeCode(forecast['type'])} : $displayValue",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}