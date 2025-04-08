// 플러터 : Dart 언어(Google) 기반의 애플리케이션 개발 프레임워크
// Dart 언어의 클래스 생성 : 첫글자 대문자로 시작
// Dart 언어의 인스턴스 생성 : 클래스명()

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// [1]
void main(){
  print("콘솔에 출력하기");

  runApp(MyApp2());

}

// [2] 클래스 생성
/*
[MyApp1 의 위젯 트리 (== 위젯 구조)]
-> MyApp(StatelessWidget) : 상태 없는 위젯(화면)
  -> build
    -> MaterialApp
      -> home
        -> Scaffold
          -> appBar
            -> AppBar
              -> Text
          -> body
            -> Text
          -> bottomNavigationBar
            -> BottomAppBar
              -> Text
*/
class MyApp1 extends StatelessWidget{ // StatelessWidget(상태가 없는 기본 위젯) 상속 받기
  @override // 상속 받은 StatelessWidget 의 build 메소드 오버라이딩
  Widget build(BuildContext context) {
    // build 메소드의 return 부분에 출력할 위젯 코드 작성
    /*
    - 위젯 : 화면을 구성하는 최소의 단위 => 클래스 기반 (== 리액트의 컴포넌트)
    - 위젯 안에 위젯 가능 (== 객체 안에 객체)
    - 위젯 사용방법
        1. 위젯명 : 클래스와 동일하게 첫글자가 대문자
        2. ( ) : 클래스명 뒤에 생성자처럼 초기값을 대입하는 매개변수 자리
            -> Java : new Member("유재석" , 40);
            -> Dart : Member(name : "유재석" , age : 40);
        => 위젯명(속성명 : 위젯명(속성명 : 위젯명()));
            -> 속성 : 각 위젯들이 정의한 속성명을 사용해야함 (!모르면 ctrl + 위젯 클릭 으로 확인하기!)
    */
    return MaterialApp(
        home : Scaffold(
          // 1) 상단메뉴 => appBar : AppBar(속성명 : 위젯명())
          // -> AppBar() 위젯은 title 속성 을 지원함
          appBar: AppBar(title : Text("여기는 상단 메뉴")),
          // 2) 본문메뉴 => body : 위젯명()
          body: Text("여기는 본문 메뉴"),
          // 3) 하단메뉴 =>  bottomNavigationBar : BottomAppBar(위젯명())
          // -> BottomAppBar() 위젯은 title 을 지원하지 않기 때문에 child 속성 사용
          bottomNavigationBar: BottomAppBar(child: Text("여기는 하단 메뉴")),
        ));
  }
}



/*
[위젯]
1. MaterialApp : 각 위젯의 틀을 정의하는 최상위 위젯
2. Scaffold : 레이아웃 제공 => 형식 : Sacaffold(속성명 : 위젯명())
  -> 상단메뉴 레이아웃 제공 => appBar : AppBar(속성명 : 위젯명())
  -> 본문메뉴 레이아웃 제공 => body : 위젯명()
  -> 하단메뉴 레이아웃 제공 =>  bottomNavigationBar : BottomAppBar(위젯명())
*/

/*
[StatelessWidget(상태없는 위젯)]
-> 고정된 (불변의 UI(화면))
*/

class MyApp2 extends StatelessWidget{

  // [1] 증가함수
  int count = 0;
  void increment(){
    count++;
    print(count);
  }


  // [2] build 오버라이딩
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp() : 틀을 제공하는 최상위 위젯
      home: Scaffold(   // Scaffold() : 레이아웃을 제공하는 위젯
        appBar: AppBar(title: Text("상단텍스트")), // AppBar() : 상단 메뉴 레이아웃 제공
        body: Center( // Center() : 가운데 정렬
          child: Column( // child : 자식 요소 1개 // Column() : 세로 배치
            children: [  // children : 자식 요소 여러개 (List) => Column() 위젯이 제공
              Text("본문 텍스트 : $count"),
              TextButton( // TextButton() : 텍스트 버튼을 제공하는 위젯
                  onPressed: increment , // onPressed : onClick 시 => 증가함수에 적용
                  child: Text("버튼에 넣을 텍스트")
                  // 버튼 클릭 시 count 변수의 값은 증가하지만 StatelessWidget 상태이기 때문에 화면의 $count 는 증가 X

              )
            ],
          ),
        ),
      ),
    );
  }
}