// detail.dart : 상세페이지 화면 //

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 페이지
class Detail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

// [2] 상태 사용 페이지
class _DetailState extends State<Detail>{
  // [*] 자바와의 통신을 위한 Dio 객체 선언
  Dio dio = Dio();

  // [*] 이전 화면("/")에서 arguments 로 보낸 매개변수 값을 가져오기
  // (1) didChangeDependencies 메소드 오버라이딩
  @override
  void didChangeDependencies() { // didChangeDependencies() : 부모위젯이 변경 시 실행되는 함수
                                 // ★ context (위젯트리)를 제공받기 위해 initState() 대신 didChanggeDependencies() 사용 ★
    // (2) 매개변수 가져오기
    // => ModalRoute.of(context)!.settings.arguments as 인자값의 타입;
    int id = ModalRoute.of(context)!.settings.arguments as int;

    // (3) 자바와 통신하는 메소드에게 매개변수로 전달
    todoFindById(id);
  }

  // [*] 자바와 통신하여 id에 해당하는 상세정보 요청
  Map<String, dynamic> todo = {}; // 응답 객체를 저장하는 객체 선언
  void todoFindById(id) async {
    try{

      // 매개변수로 전달받은 id 를 쿼리스트링으로 전달
      final response = await dio.get("https://open-bendite-tjoeun-02a1a58d.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;

      // 응답받은 결과를 상태변수에 대입
      setState(() {
        todo = data;
      });

      print(todo);
    }catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("제목 : ${todo['title']}", style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,),
            Text("내용 : ${todo['content']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),
            Text("완료여부 : ${todo['done']}", style: TextStyle(fontSize: 13),),
            SizedBox(height: 8,),
            Text("등록날짜 : ${todo['createAt']}", style: TextStyle(fontSize: 13),),
            SizedBox(height: 8,),

          ],
        ),
      ) ,
    );
  }
}