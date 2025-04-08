// StatefulWidget + REST 통신 //

// [1] main 함수 선언
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main(){
  runApp(MyApp()); // 상태관리클래스 실행
}

// [2] 상태관리클래스 선언
class MyApp extends StatefulWidget{

  // 1) 상태사용클래스와 연결
  // StatefulWidget 을 상속받은 관리클래스 선언 시 createState() 오버라이딩(사용 클래스와 연결) 필수 //
  // 1_ 람다식 방식 : MyAppState createState() => MyAppState();
  // 2_ 기본 방식 :
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

// [3] 상태사용클래스 선언
class MyAppState extends State<MyApp>{
  // *) dio 객체 생성
  Dio dio = Dio();
  // *) 자바에게 받은 반환값을 저장할 상태변수 선언
  String responseText = "서버 응답 결과가 표시되는 곳";


  // 1) 자바와 통신할 메소드 선언
  void todoSend() async{ // 동기화
    // - 예외처리
    try{
      // - 자바에게 보낼 샘플 객체 생성
      final sendData = {"title" : "운동하기", "content" : "꼭!", "done" : "false"};

      // - 자바와 POST 통신 후 반환값 받기
      final response = await dio.post("http://192.168.40.34:8080/day04/todos", data: sendData);
        // -> 플러터 앱과 통신 시 localhost X IP 로 통신해야함

      // - 반환값이 대입된 변수 선언
      final data = response.data;
      
      print(data);

      // - setState() 함수를 통해 자바의 반환값을 상태변수에 저장
      setState(() {
        responseText = "응답결과 : $data";
      });

    }catch(e){
      setState(() {
        responseText = "에러발생 : $e";
      });
    }

  }

  // 2) build 함수 오버라이딩
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: todoSend, // 자바와 통신할 메소드
                  child: Text("자바통신버튼")),
              Text(responseText)
            ],
          ),
        ),
      ),
    );
  }
}