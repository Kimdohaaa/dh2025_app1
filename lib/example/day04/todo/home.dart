// home.dart : 메인 화면을 가지는 앱의 파일 //

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 클래스
// 1) StatefulWidget 상속 받기
class Home extends StatefulWidget{
  // 2) 상태 사용 클래스와 연결
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

// [2] 상태 사용 클래스
// 1) 상태 관리 클래스 상속 받기
class _HomeState extends State<Home>{
    // 클래스 명 앞에 _(언더바) : private

  // [*] GET : 자바에서 할일 목록 가져오기
  // (1) Dio 객체 생성
  Dio dio = Dio();

  // (2) 할일목록을 저장할 리스트 선언
  List<dynamic> todoList = [];

  // (3) Dio 를 통해 자바와 통신하는 함수 선언
  void todoFindALl() async{
    // (#) 예외처리
    try{
      // (#) 자바와 통신 후 반환값 받아오기
      final response = await dio.get("https://open-bendite-tjoeun-02a1a58d.koyeb.app/day04/todos");

      // (#) 반환값을 변수에 대입하기
      final data = response.data;

      // (#) setState 를 통해 재 렌더링
      setState(() {
        // (#) 자바로부터 응답받은 결과 state 상태변수에 저장
        todoList = data;
      });

      // (#) 결과 확인
      print(todoList);
    }catch(e){
      print(e);
    }

  }
  // (4) _HomeState 가 최초로 열렸을 때 todoFindAll 메소드 최초 1회 실행
  @override
  void initState() {
    super.initState();
    todoFindALl();
  }

  // [*] DELETE : 자바에서 할일 삭제하기
  void todoDelete(id) async{ // 삭제할 PK 키 를 매개변수로 받음
    try{
      final response = await dio.delete("https://open-bendite-tjoeun-02a1a58d.koyeb.app/day04/todos?id=$id");
        // 쿼리스트링으로 PK 키 전달

      if(response.data == true){
        todoFindALl(); // 삭제 성공 시 할일 목록 다시 조회
      }else{

      }
    }catch(e){
      print(e);
    }

  }
  // 2) build 메소드 오버라이딩
  @override
  Widget build(BuildContext context) {
    return Scaffold( // main.dart 파일에서 MaterialApp() 위젯을 이미 선언함
      appBar: AppBar(title: Text("Main Page : TODO")),
      body: Center(
        child: Column(
          children: [
            // #. 등록 화면으로 이동하는 버튼 //
            TextButton(
                onPressed: () => {Navigator.pushNamed(context, "/write")},
                child: Text("할일 추가")),

            // #. 간격
            SizedBox(height: 30),

            // #. ListView() 위젯을 이용한 할일 목록 출력
            // (1) 자바로부터 가져온 List 를 map 함수를 이용하여 Card 형식의 위젯으로 만든 뒤 출력
            Expanded( // Column() 위젯 내에서 ListView() 위젯사용 시 Expanded() 위젯 안에서 사용해야함
                child: ListView( // 높이 100% 의 자동 세로 스크롤을 지원하는 위젯
                  children: // map() 사용 시 반환값이 List 이기 때문에 대괄호 생략
                    todoList.map((todo) {
                      return Card(child: ListTile(
                        title: Text(todo['title']), // 제목 (한 개만 출력 가능)
                        subtitle: Column( // 부제목 (여러개 출력 가능)
                          children: [
                            Text("할일내용 : ${todo['content']}"),
                            Text("할일상태 : ${todo['done']}"),
                            Text("등록날짜 : ${todo['createAt']}")
                            // 변수값만 출력 시 : "문자열 $변수명"
                            // 객체의 Key의 value 출력 시 : "문자열 ${변수명['key']}"
                          ],
                        ),


                        trailing: // trailing : ListTile 오른 쪽 끝에 표시되는 위젯
                          Row( // Row() : 하위 위젯 가로 배치
                            mainAxisSize : MainAxisSize.min, // trailing 하위 위젯의 사이지를 자동으로 할당
                            children: [

                              // #. 수정 버튼
                              IconButton(
                                  onPressed: () => {Navigator.pushNamed(context, "/update", arguments: todo['id'])},
                                  icon: Icon(Icons.edit)
                              ),

                              // #. 상세 보기 버튼
                              IconButton(
                                  // => 상세보기 버튼 클릭 시 "/detail" 경로로 이동 / 해당 경로에 todoList 의 'id'를 매개변수로 보냄
                                  onPressed: () => {Navigator.pushNamed(context, "/detail", arguments: todo['id'])},
                                  icon: Icon( Icons.info)
                              ),

                              // #. 삭제 버튼
                              IconButton( // IconButton() : 아이콘 버튼을 출력하는 위젯
                                  onPressed: () => {todoDelete(todo['id'])}, // PK 키를 삭제 메소드에게 매개변수로 전달
                                  icon: Icon(Icons.delete)
                              )

                            ]
                          )
                      ),
                      );
                    }).toList()
                  ,
                )
            )
          ],
        ),
      ),
    );
  }
}

// *** 생성한 Home 클래스 main.dart 에서 import 하기 *** //