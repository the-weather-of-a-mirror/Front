import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whether/WarningScreen/DisasterWarning.dart';
import 'package:whether/WarningScreen/SaveTool.dart';
import 'package:whether/WarningScreen/ShelterInfo.dart';
import '../main.dart';




class WarningScreen extends StatelessWidget{
  
  final List<String> warningText = ["대피소 정보", "구호 물품", "재난 대피시\n주의사항"];
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: warningText.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // 탭 이벤트 발생 시 AlertDialog 표시
            // ignore: unrelated_type_equality_checks
            if ((index) == 0)
            {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ShelterInfo()));
            }
            else if(index == 1)
            {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SaveTool()));
            }
            else if(index == 2)
            {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => Disasterwarning()));
            }
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.primaries[(index + 10) % Colors.primaries.length],
            child: Center(
              child: Text(
                warningText[index],
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}