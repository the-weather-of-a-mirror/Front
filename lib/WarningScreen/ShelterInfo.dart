import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';


class ShelterInfo extends StatelessWidget {
  final List<Map<String, dynamic>> shelters = [
    {'name': '화성시 봉담읍 oo대피소', 'capacity': 100, 'current': 69},
    {'name': '화성시 봉담읍 □□대피소', 'capacity': 100, 'current': 74},
    {'name': '화성시 봉담읍 aa대피소', 'capacity': 200, 'current': 169},
    {'name': '화성시 봉담읍 bb대피소', 'capacity': 150, 'current': 150},
    {'name': '화성시 봉담읍 cc대피소', 'capacity': 200, 'current': 174},
    // 필요한 만큼 추가
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대피소 정보'),
      ),
      body: ListView.builder(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('정원 : ${shelter['capacity']}명 현재 : ${shelter['current']}명'),
              ],
            ),
          ),
        );
      },
      )
    );
  }
}
