// myapp.dart : 레이아웃을 구성하는 파일

import 'package:dh2025_app1/app/layout/mainapp.dart';
import 'package:flutter/material.dart';

// 상태가 없는 위젯 선언
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "더 조은 앱",
      // mainapp.dart 파일의 MainApp 위젯 실행 //
      home: MainApp(),
      // ThemeData() : 앱 테마를 구성하는 위젯
      theme: ThemeData(
        // Scaffforld 위젯의 색상 구성을 지정
        scaffoldBackgroundColor: Colors.white
      ),
    );
  }
}