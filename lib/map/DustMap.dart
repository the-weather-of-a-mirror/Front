import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DustMap extends StatefulWidget {
  @override
  _DustMapState createState() => _DustMapState();
}


class _DustMapState extends State<DustMap> {
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDust();
  }

 void changeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('mapState',0);
    print(prefs.getInt('mapState'));
  }
  Future<void> getDust() async {
    var request = http.Request(
        'GET', Uri.parse('http://223.195.109.34:8080/mirror/weather/nation/dust'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String dustData = await response.stream.bytesToString();

      final data = json.decode(dustData);

      // Extracting the 'informGrade' string
      String informGrade = data['data']['response']['body']['items'][0]['informGrade'];

      // Splitting the informGrade string into regions and dust conditions
      List<Map<String, String>> dustMap = [];
      List<String> regionsAndConditions = informGrade.split(',');

      for (var regionAndCondition in regionsAndConditions) {
        var parts = regionAndCondition.split(':');
        if (parts.length == 2) {
          String region = parts[0].trim();
          String dust = parts[1].trim();
          dustMap.add({"region": region, "dust": dust});
        }
      }

      // Now `dustMap` contains the region names and their corresponding dust condition
      setState(() {
        // Store it in weatherData for display
        weatherData = { 'data': dustMap };  // Corrected: Store the full list
        isLoading = false;
      });

      print(weatherData);  // For debugging purposes
    } else {
      print('Failed to fetch dust data: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A2E8),
      appBar: AppBar(
        title: Text("미세먼지 지도",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? Center(
                child: Text(
                  '로딩중',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            : CustomWeatherMap(
                weatherData: weatherData,
                width: 350, // 고정된 너비
                height: 500, // 고정된 높이
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeData,
        backgroundColor: Colors.black,
        child: Icon(Icons.sync, color: Colors.white),
      ),
    );
  }
}

class CustomWeatherMap extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final double width;
  final double height;

  const CustomWeatherMap({
    Key? key,
    required this.weatherData,
    this.width = 300.0,
    this.height = 400.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cities = {
      '서울': Offset(0.38, 0.25),
      '제주': Offset(0.13, 0.87),
      '전남': Offset(0.33, 0.65),
      '전북': Offset(0.35, 0.53),
      '대구': Offset(0.6, 0.55),
      '부산': Offset(0.7, 0.68),
      '울산': Offset(0.79, 0.57),
      '경기남부': Offset(0.38, 0.38),
      '충남': Offset(0.5, 0.48),
      '경남': Offset(0.7, 0.45),
    };

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // 지도 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/map.png',
              fit: BoxFit.cover,
            ),
          ),
          // 날씨 위젯 추가
          ..._buildWeatherWidgets(cities),
        ],
      ),
    );
  }

  List<Widget> _buildWeatherWidgets(Map<String, Offset> cities) {
    List<Widget> widgets = [];
    // 'data' 안에 있는 dustMap을 사용
    List<dynamic> dustMap = weatherData['data'];

    for (var entry in dustMap) {
      String cityName = entry['region'];  // region name
      String dust = entry['dust'];        // dust condition

      if (cities.containsKey(cityName)) {
        final offset = cities[cityName]!;

        // 고정 크기에 따른 위치 계산
        double left = width * offset.dx;
        double top = height * offset.dy;

        widgets.add(_buildWeatherInfo(
          left: left,
          top: top,
          city: cityName,
          dust: dust,
        ));
      }
    }

    return widgets;
  }

  Widget _buildWeatherInfo({
    required double left,
    required double top,
    required String city,
    required String dust,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Column(
        children: [
          Text(
            '$dust\n$city',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                shadows: [
                  Shadow(color: Colors.white, blurRadius: 2),
                ],
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
