import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';


class WhatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text('여기다 뭐하지',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          ),
        ),
      ),
    );
  }
}