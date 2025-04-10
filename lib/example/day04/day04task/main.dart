
import 'package:dh2025_app1/example/day04/day04task/write.dart';
import 'package:dh2025_app1/example/day04/day04task/detail.dart';
import 'package:dh2025_app1/example/day04/day04task/update.dart';
import 'package:dh2025_app1/example/day04/day04task/home.dart';

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: { // 2) 각 클래스의 라우터 경로 설정
        "/" : (context) => Home(), // 만약 "/" 경로 호출 시 Home() 클래스 오픈
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update()
      },
    );
  }
}