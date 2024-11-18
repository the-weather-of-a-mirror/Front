import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';

class Disasterwarning extends StatelessWidget {
  final List<Map<String, dynamic>> shelters = [
    {
      'name': '지진',
      'details': '''
🌍 **지진이 발생하면 이렇게 대피합니다** 🌍  

1️⃣ **튼튼한 탁자 아래에 들어가 몸을 보호합니다.**  
   - 지진으로 크게 흔들리는 시간은 길어야 1~2분 정도입니다.  
   - 튼튼한 탁자 아래로 들어가 탁자 다리를 꼭 잡고 몸을 보호하세요.  
   - 탁자 아래와 같이 피할 곳이 없을 때에는 방석 등으로 머리를 보호합니다.  

2️⃣ **가스와 전깃불을 차단하고 문을 열어 출구를 확보합니다.**  
   - 흔들림이 멈춘 후 당황하지 말고 화재에 대비하여 가스와 전깃불을 끕니다.  
   - 문이나 창문을 열어 언제든 대피할 수 있도록 출구를 확보합니다.  

3️⃣ **집에서 나갈 때는 신발을 신고 이동합니다.**  
   - 유리 조각이나 떨어져 있는 물체 때문에 발을 다칠 수 있으니, 발을 보호할 수 있는 신발을 꼭 신고 이동하세요.  

4️⃣ **계단을 이용하여 밖으로 대피합니다.**  
   - 엘리베이터가 멈출 수 있으므로 타지 말고, 계단을 이용하여 건물 밖으로 대피하세요.  

5️⃣ **건물이나 담장으로부터 떨어져 이동합니다.**  
   - 건물 밖으로 나오면 담장, 유리창 등이 파손되어 다칠 수 있으니, 건물과 담장에서 최대한 멀리 떨어져 가방이나 손으로 머리를 보호하면서 대피하세요.  
   - 담장이나 전봇대는 지진으로 파손되거나 지반도 약해져 넘어질 수 있으니 기대지 마세요.  

6️⃣ **낙하물이 없는 넓은 공간으로 대피합니다.**  
   - 운동장이나 공원 등 넓은 공간으로 신속히 이동하세요.  
   - 차량을 이용하지 말고 걸어서 대피하며, 떨어지는 물건에 주의하세요.
'''
    },
    {'name': '태풍', 'details': ''},
    {'name': '화재', 'details': ''},
    {'name': '폭우', 'details': ''},
    {'name': '정전', 'details': ''},
    {'name': '해일', 'details': ''},
    {'name': '홍수', 'details': ''},
    {'name': '폭염', 'details': ''},
    {'name': '한파', 'details': ''},
    {'name': '폭설', 'details': ''},
    {'name': '낙뢰', 'details': ''},
    {'name': '가뭄', 'details': ''},
    {'name': '전쟁', 'details': ''},
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
          return GestureDetector(
            onTap: () {
              if (shelter['details']?.isNotEmpty ?? false) {
                // 팝업 다이얼로그 표시
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(shelter['name']),
                    content: SingleChildScrollView(
                      child: Text(shelter['details']),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('닫기'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      shelter['name'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
