import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';




class SaveTool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], 
      appBar: AppBar(
        title: Text('구호물품'),
                        
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '집에 비치할 것',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '라면 통조림, 가열없이 먹을 수 있는 식품 (30일분)\n'
                    '버너 부탄가스 (15개 이상)\n'
                    '물, 응급약품, 개인위생용품, 라디오, 배낭, 전등,\n양초, '
                    '라이터, 비누, 소금, 여성 위생용품, 배터리,\n신발, 장갑, 소화기',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          // 대피 준비물품 Card
          Card(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '대피 준비물품',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '생수, 간편식, 손전등, 상비약, 라디오(건전지),\n화장지(물티슈), '
                    '우의, 담요, 방독면, 마스크\n'
                    '보온력이 좋은 옷\n'
                    '현금 및 열쇠 세트\n'
                    '신분증, 비상 연락처, 행동요령, 지도 등이 있는\n재해지도 또는 수첩',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
