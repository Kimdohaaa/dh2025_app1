
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){ // main() : Dart 프로그램의 진입점

  // 생성한 화면 [1] 실행 : runApp(출력할 클래스명) //
  // runApp(MyApp1());
  /*
  [실행방법_1 (web)]
  1. 메뉴 상단에 'select device' 에서 출력할 브라우저 선택
  2. main() 실행
  [실행방법_2]
  1. 'Device Manager' 에 출력할 device 실행
  2. 'select device' 에서 실행된 device 선택
  3. main() 실행
  */
  // 생성한 화면 [2] 실행 : runApp(출력할 클래스명)
  runApp(MyApp2());

}
// [1] 간단한 화면 생성
// 1) 위젯 클래스 생성 : class 클래스명 extends StatelessWidget{ }
// => StatelessWidget : 상태가 없는 인터페이스(1개의 추상메소드(.build())를 제공하므로 오버라이딩 필수)
class MyApp1 extends StatelessWidget{
  // 2) ctrl + spaceBar 를 통해 build() 추상메소드 오버라이딩
  @override
  Widget build(BuildContext context) {
    // 3) 출력할 위젯(==React 의 컴포넌트) 리턴 : MaterialApp(home: Text("안녕"))
    return MaterialApp(home: Text("안녕ㅋ"));
  }
}

// [2] 간단한 레이아웃 화면 만드릭
class MyApp2 extends StatelessWidget{
  // Text() : 문자열 작성 시 필수로 적용해야 하는 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("여기는 상단")), // appBar : 상단 메뉴바
      body: Center(child: Text("여기는 본문")), // body : 본문
      bottomNavigationBar: BottomAppBar(child: Text("여기는 하단")), // bottomNavigationBar : 하단 메뉴
    ));
  }
}