/*
[상태(state/데이터의 변환)가 없는 위젯 : StatelessWidget]
-> 한 번 출력된 화면은 불변(고정) => 리렌더링 불가
-> 관리 클래스가 별도로 필요하지 않음
-> 정적 UI
-> StatelessWidget 사용법
  1) class 클래스명 extends StatelessWidget{
        @Override
        Widget build(BuildContext context){
          return 출력할 위젯 코드 ;
        }
     }
  2) main() 메소드에서 runApp() 을 통해 StatelessWidget 위젯 클래스 켜기

[상태(state/데이터의 변환)가 있는 위젯 : StatefulWidget => 리렌더링(새로고침) 가능]
-> 한 번 출력된 화면은 불변(고정) => setState() 를 통해 리렌더링 가능
-> !!! 상태를 관리하는 별도의 클래스 필수 !!!
-> 동적 UI
-> StatefulWidget 의 주요 메소드
  1) initState() : 위젯이 처음 생성될 때 실행되는 초기화 함수
    => 위젯의 탄생
    => 해당 메소드 실행 시 REST API 통신
  2) setState() : 상태를 변경하고 UI 를 리렌더링(다시 build() 메소드 실행)함 (주로 버튼과 많이 사용)
    => 위젯의 인생 (업데이트)
  3) dispose() : 위제싱 제거될 때 실행되는 함수
    => 위젯의 사망

-> StatefulWidget 사용법
  1) 상태를 관리하는 클래스 선언
    class 관리클래스명 extends StatefulWidget{
      연결할사용클래스명1 createState() => 연결할사용클래스명1();
      연결할사용클래스명2 createState() => 연결할사용클래스명2();
      연결할사용클래스명3 createState() => 연결할사용클래스명3();
      => 여러 개의 사용클래스 연결 가능
    }

  2) 상태를 사용하는 클래스 선언
    class 사용클래스명 extends State<관리클래스명>{
      return 출력할 위젯 코드;
    }

  3) main() 메소드에서 runApp() 을 통해 관리클래스 켜기 (사용클래스 XXX)
*/

import 'package:flutter/material.dart';

void main(){

  // runApp() 시 상태를 사용하는 클래스가 아닌 관리하는 클래스를 켜야함 //
  runApp(MyApp1());
}

// [1] 상태를 관리하는 클래스(위젯) 선언
// 1) 상태가 있는 위젯을 제공하는 StatefulWidget 클래스 상속 받기
class MyApp1 extends StatefulWidget{
  // 2) createState() : 상태를 사용할 위젯과 연결하기
  // -> 연결할사용클래스 createState() => 연결할사용클래스();
  MyApp1State createState() => MyApp1State();

}

// [2] 상태를 사용하는 클래스(위젯) 선언
// -> 형식 : class 클래스명 extends State<관리클래스>{ build 메소드 오버라이딩 코드; }
class MyApp1State extends State<MyApp1>{

  // 1) 증가 함수
  int count = 0;
  void increment (){
    // count++;

    // 2) setState() : 상태변화에 따른 리렌더링
    setState(() {
      count++; // 상태변화를 출력하기 위해 해당 위치에서 ++ 하기
    });
    
  }
  
  // 3) initState() : 상태 위젯이 최초로 실행될 때 딱 한번 실행되는 함수 (== 리액트의 useEffect)
  @override
  void initState() {
    print("상태 위젯 최초 1회 실행 함수");
  }
  
  // 4) build()
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:  Text("상단메뉴"),),
        body: Center(
          child: Column(
            children: [
              Text("count : $count"),
              TextButton(
                  onPressed: increment,
                  child: Text("누르면 count 증가")
              )
            ],
          ),
        ),
      ),
    );

  }
}