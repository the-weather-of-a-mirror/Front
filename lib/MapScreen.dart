import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('http://223.195.109.34:8080/mirror/weather/weatherMapService');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherData = data['data']['results']['choiceResult']['nationFcast'];
        isLoading = false;
      });
    } else {
      print('Failed to fetch weather data: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A2E8),
      appBar: AppBar(
        title: Text("날씨 지도",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? Center(
                  child: Text(
                    '로그인을 해주세요.',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                )
            : CustomWeatherMap(
                weatherData: weatherData,
                width: 350, // 고정된 너비
                height: 500, // 고정된 높이
              ),
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
      '춘천': Offset(0.53, 0.18),
      '서울': Offset(0.38, 0.25),
      '강릉': Offset(0.63, 0.28),
      '청주': Offset(0.55, 0.37),
      '수원': Offset(0.38, 0.38),
      '대전': Offset(0.5, 0.48),
      '안동': Offset(0.7, 0.45),
      '전주': Offset(0.35, 0.53),
      '대구': Offset(0.6, 0.55),
      '광주': Offset(0.33, 0.65),
      '부산': Offset(0.7, 0.68),
      '울산': Offset(0.79, 0.57),
      '목포': Offset(0.2, 0.75),
      '제주': Offset(0.13, 0.87),
      '여수': Offset(0.45, 0.75),
      '울릉/독도': Offset(0.8, 0.33),
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
    weatherData.forEach((key, value) {
      final cityName = value['regionName'];
      final temperature = value['tmpr'];
      final weatherText = value['wetrTxt'];

      if (cities.containsKey(cityName)) {
        final offset = cities[cityName]!;

        // 고정 크기에 따른 위치 계산
        double left = width * offset.dx;
        double top = height * offset.dy;

        widgets.add(_buildWeatherInfo(
          left: left,
          top: top,
          city: cityName,
          temperature: temperature,
          weather: weatherText,
        ));
      }
    });

    return widgets;
  }

  Widget _buildWeatherInfo({
    required double left,
    required double top,
    required String city,
    required double temperature,
    required String weather,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Column(
        children: [
          Text(
            '$weather\n$city${temperature.toStringAsFixed(1)}°',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 12, shadows: [
              Shadow(color: Colors.white, blurRadius: 2),
            ],
            fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
