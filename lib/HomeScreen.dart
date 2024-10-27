import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body:  
      
       Container(
           color: Colors.yellow,
           width: 1000,
           child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  width: 1000,
                  child: 
                Container(
          
              margin: EdgeInsets.only(top: 190,bottom: 190),
         
            child: const Text('2024-10-09\n화성시 봉담읍\n날씨 맑음, 미세먼지 좋음',
           
             textAlign: TextAlign.center),
            ),
                ),
            Container(
              color : Colors.green,
              width: 10000,
              height: 126.4,
              child:   
            Container(            
              child: Text('10월 재난정보\n1~10월 가뭄 예보\n10~20일 태풍 예보\n20일~30일 장마 예보',
               textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20),
              height:80,
                        
              ),
            ),
              ],
            ),
            
           ),
           
      
      
      
    );    
  }
}

