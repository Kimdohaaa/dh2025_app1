// day04 : 라우터를 이용한 화면 전환

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// [1] main : 플러터의 시작점
void main(){
  // 1) runApp() 을 통해 최초로 실행할 위젯의 객체 대입
  // 라우터 사용 : runApp(MaterialApp(속성명1 : 위젯 , 속성명2 : 위젯));
  // => 최초 실행 시 보통 라우터를 실행시키기 때문에 MaterialApp() 을 실행시킴
  runApp(MaterialApp(
    initialRoute: "/" , // initialRoute : 최초 실행 시 열리는 경로 지정
    routes: { // routes: {"경로" : (context) => 위젯명()}
      "/" : (context) => Home(),
      "/page1" : (context) => Page1(), // 경로이동시 http://localhost:64140/#/page1 중간에 # 사용
//      "/page3" : (context) => Page3()
    },
  ));
}

// [2] 앱 화면 만들기 (상태X 버전)

// 1) StatelessWidget 클래스 상속받기
class Home extends StatelessWidget{
  // 2) build 메소드 오버라이딩
  @override
  Widget build(BuildContext context) {
    // 3) 출력할 위젯 코드 작성
    return Scaffold(
      appBar: AppBar(title: Text("MAINPAGE 헤더")),
      body: Center(
          child: Column(
            children: [
              Text("MAINPAGE 본문"),

           /*
           [특정 경로로 이동]
           TextButton(
              onPressed: () => {Navigator.pushNamed(context, "이동할 경로")},
              child: Text("PAGE1 로 이동")
           )

           [이전 경로로 이동]
           TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text("이전 경로로 이동")
           )
           */

          TextButton(
                  onPressed: () => {Navigator.pushNamed(context, "/page1")},
                  child: Text("PAGE1 로 이동")
              )
            ],
          )
      )
    );
      
  }
}

class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PAGE1 헤더")),
      body: Center(child: Text("PAGE1 본문"),),
    );
  }
}