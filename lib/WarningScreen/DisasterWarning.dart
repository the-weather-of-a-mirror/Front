import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';


class Disasterwarning extends StatelessWidget {
  final List<Map<String, dynamic>> shelters = [
    {'name': '지진'},
    {'name': '태풍'},
    {'name': '화재'},
    {'name': '폭우'},
    {'name': '정전'},
    {'name': '해일'},
    {'name': '홍수'},
    {'name': '폭염'},
    {'name': '한파'},
    {'name': '폭설'},
    {'name': '낙뢰'},
    {'name': '가뭄'},
    {'name': '전쟁'},

    // 필요한 만큼 추가
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('재난 대피시 주의 사항'),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  shelter['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
              
                ),
              ],
            ),
          ),
        );
      },
      )
    );
  }
}
