// text 입력폼 //

// [1] 시작점
import 'package:dh2025_app1/example/day03/example3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// [2] 상태가 있는 앱 화면 클래스 선언
// [2-1] 상태를 관리하는 화면 클래스
// 1) StatefulWidget 상속 받기
class MyApp extends StatefulWidget{
  // 2) 상태를 사용할 클래스와 연결
  MyAppState createState() => MyAppState();
}

// [2-2] 상태를 사용하는 화면 클래스
// 1) 상태 관리 클래스 상속 받기
class MyAppState extends State<MyApp>{
  // [*] 입력 컨트롤러를 이용하여 사용자가 입력한 값 제어
  // [*-1] 컨트롤러 객체 선언
  // -> final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  // [*-2] 사용자가 입력한 값을 입력 컨트롤러 객체에 대입
  // -> TextField(controller : 컨트롤러 객체명)


  // [*-3] 대입된 입력값 추출
  // -> 입력컨트롤러객체명.text

  void onEvent(){
    print(controller1.text);
    print(controller2.text);
    print(controller3.text);
  }

  // 2) build 오버라이딩
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("입력 화면 헤더")),
      body: Center(
        child: Column(
          children: [
            // 입력폼 //
            SizedBox(height: 30), // SizedBox() : 빈공간을 만드는 위젯
            Text("아래 내용들을 입력하세요"), // Text() : 텍스트 출력 위젯
            SizedBox(height: 30),
            // [*-2] 위에서 선언한 컨트로럴 객체에게 입력값 전달
            TextField(controller:  controller1,), // TextField() : 텍스트 입력 위젯 (== HTML input)
            SizedBox(height: 30),
            TextField(maxLength:  30, controller: controller2,), // 입력 텍스트의 최대길이를 30으로 지정
            SizedBox(height: 30),
            TextField(
              maxLines: 5, // 최대 입력 줄 수를 5줄로 제한(입력에 따라 자동 확장됨)
              controller: controller3,
              decoration: InputDecoration(labelText: "가이드 텍스트"),
            ),

            // 입력버튼 //
            TextButton(
                onPressed: onEvent,
                child: Text("입력값 출력 버튼")
            )
          ],
        ),
      ),
    ),
    );
  }
}