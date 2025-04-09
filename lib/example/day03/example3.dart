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
  // *) 자바에게 받은 반환값을 저장할 상태변수 선언  (POST)
  String responseText = "서버 응답 결과가 표시되는 곳";


  // 1) 자바와 통신할 메소드 선언 (POST)
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
        responseText = "POST결과 : $data";
      });

    }catch(e){
      setState(() {
        responseText = "에러발생 : $e";
      });
    }

  }

  // 2) 자바와 통신할 메소드 선언 (GET)
  // *) 자바에게 받은 반환값을 저장할 상태변수 선언  (POST)
  List<dynamic> todoList = [];
  void todoGet() async{
    try{
      final response = await dio.get("http://192.168.40.34:8080/day04/todos");

      final data = response.data;
      print(data);

      setState(() {
        todoList = data;
      });


    }catch(e) {
      setState(() {
        todoList = [];
      });

    }
  }

  // [***] 위젯 실행 시 최조로 1번 실행
  @override
  void initState() {
    super.initState();
    todoGet(); // 전체조회 통신 메소드를 최초 1회 실행
  }
  // 2) build 함수 오버라이딩
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [

              // [*] POST 통신 버튼
              TextButton(
                  onPressed: todoSend, // 자바와 통신할 메소드 (POST)
                  child: Text("POST 통신버튼")),
              Text(responseText), // 자바 통신 결과 (POST)

              // [*] GET 통신 버튼
              TextButton(
                  onPressed: todoGet, // 자바와 통신할 메소드 (GET)
                  child: Text("GET 통신버튼")),

              Expanded( // Expanded() : Column() 위젯이 출력에 사용하고 남은 공간을 모두 채워주는 위젯
                        // -> ListView() 위젯이 부모 요소의 100% 높이를 사용하기 때문에 주로 같이 사용함
                  child: ListView( // ListView() : 스크롤이 가능한 목록(리스트) 위젯 (== HTML 의 ol, ul)
                    children: // [ // map 사용을 위해 대괄호 생략

                      // [*방법_1*] ListTile() 위젯 사용
                      // ListTile() : 목록(리스트)에 대입할 항목 위젯 (== HTML 의 li)
                      // ListTile(title: Text("플러터"), subtitle: Text("123"),),
                      // ListTile(title: Text("다트"), subtitle: Text("456"),),
                      // ListTile(title: Text("파이썬"), subtitle: Text("789"),)

                      // 자바의 반환값을 가진 상태변수에 잇는 모든 값을 반복문을 이용하여 출력 //
                      // [*방법_2*] for 문
                      // for(int i = 0; i < todoList.length ; i++) // 중괄호 사용 XXX
                      //   ListTile(title: Text(todoList[i]['title']), subtitle: Text(todoList[i]['content']))

                      // [*방법_2*] map (map 사용 시 상위 요소의 대괄호 XXX => map 자체의 반환타입이 List 이기 ㄸ매ㅜㄴ)
                      todoList.map((todo)  { // => 생략 가능
                        return ListTile(title: Text(todo['title']));
                      }).toList() // List명.map((반복변수명) { return 위젯명; }.toList() // toList() : 타입변환
                    // ] // map 사용을 위해 대괄호 생략
                    ,
                  )

              )
            ],
          ),
        ),
      ),
    );
  }
}