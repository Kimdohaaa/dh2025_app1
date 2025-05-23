// main.dart : 앱 실행의 최초 파일 //
import 'package:dh2025_app1/example/day04/todo/home.dart';
import 'package:dh2025_app1/example/day04/todo/update.dart';
import 'package:dh2025_app1/example/day04/todo/write.dart';
import 'package:dh2025_app1/example/day04/todo/detail.dart';

import 'package:flutter/material.dart';

// [1] main 함수 이용한 앱 실행

void main(){
  runApp(MyApp()); // material.dart runApp() 으로 작성
                   // 라우터를 가지는 클래스를 runApp() 을 통해 최초 실행
}

// [2] 라우터를 가지는 클래스 선언
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/", // 1)  앱 실행 시 초기 경로 설정
      routes: { // 2) 각 클래스의 라우터 경로 설정
        "/" : (context) => Home(), // 만약 "/" 경로 호출 시 Home() 클래스 오픈
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update()
      },
    );
  }
}

// 실행 흐름 : MyApp -> MaterialApp -> Home(->_HomeState)/Write(->_WriteState)/Update(->_UpdateState)

