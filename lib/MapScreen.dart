
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Text('지도',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
        ),
      ),
    );
  }
}