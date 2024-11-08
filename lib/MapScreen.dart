import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 지도 이미지 배경
          Positioned.fill(
            child: Image.asset(
              'assets/map.jpg',
              fit: BoxFit.fill,
            ),
            
          ),
          // 도시별 날씨 정보 표시
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.5, top: MediaQuery.of(context).size.height * 0.25, city: '춘천', temperature: 7.2, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.35, top: MediaQuery.of(context).size.height * 0.35, city: '서울', temperature: 6.9, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.63, top: MediaQuery.of(context).size.height * 0.3, city: '강릉', temperature: 11.3, icon: Icons.cloud),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.55, top: MediaQuery.of(context).size.height * 0.37, city: '청주', temperature: 8.3, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.35, top: MediaQuery.of(context).size.height * 0.43, city: '수원', temperature: 7.7, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.5, top: MediaQuery.of(context).size.height * 0.48, city: '대전', temperature: 7.2, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.7, top: MediaQuery.of(context).size.height * 0.45, city: '안동', temperature: 9.3, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.35, top: MediaQuery.of(context).size.height * 0.53, city: '전주', temperature: 10.1, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.6, top: MediaQuery.of(context).size.height * 0.55, city: '대구', temperature: 11.2, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.35, top: MediaQuery.of(context).size.height * 0.6, city: '광주', temperature: 10.8, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.7, top: MediaQuery.of(context).size.height * 0.65, city: '부산', temperature: 12.6, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.79, top: MediaQuery.of(context).size.height * 0.57, city: '울산', temperature: 11.3, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.2, top: MediaQuery.of(context).size.height * 0.66, city: '목포', temperature: 12.4, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.2, top: MediaQuery.of(context).size.height * 0.75, city: '제주', temperature: 12.6, icon: Icons.cloud),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.5, top: MediaQuery.of(context).size.height * 0.66, city: '여수', temperature: 11.2, icon: Icons.wb_sunny),
          _buildWeatherInfo(left: MediaQuery.of(context).size.width * 0.8, top: MediaQuery.of(context).size.height * 0.38, city: '독도', temperature: 12.2, icon: Icons.cloud),
        ],
      ),
    );
  }


  // 도시 날씨 정보를 표시하는 위젯 함수
  Widget _buildWeatherInfo({
    required double left,
    required double top,
    required String city,
    required double temperature,
    required IconData icon,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Column(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          Text(
            '$city ${temperature.toStringAsFixed(1)}°',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}