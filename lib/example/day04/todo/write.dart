// write.dart : 할일 등록 화면 파일

import 'package:dh2025_app1/example/day02/example2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 클래스
class Write extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WriteState();
  }
}

// [2] 상태 사용 클래스
class _WriteState extends State<Write>{

  // [#] 입력컨트롤러를 통해 사용자가 입력한 값 제어
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // [*] 자바와 통신하여 할일 등록하기
  Dio dio = Dio();

  void todoSave() async{
    try{
      // (1) body 로 보낼 객체 선언
      final sendData = {
        "title" : titleController.text,
        "content" : contentController.text,
        "done" : "false"
      };

      // (2) 자바와 통신
      final response = await dio.post("http://192.168.40.34:8080/day04/todos", data: sendData);

      // (3) 반환값에 따른 처리
      if(response.data != null){
        // 등록 성공 시 라우터를 이용하여 메인 페이지로 이동
        Navigator.pushNamed(context,"/");
      }
    }catch(e){
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("할일 등록 페이지")),
      body: Center(
        child: Column(
          children: [
            Text("할일을 등록하세요."),
            SizedBox(height: 30),
            // #. title 입력받기
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "할일제목"),
              maxLength:  30,
            ),

            SizedBox(height: 30),

            // #. content 입력받기
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "할일내용"),
              maxLines: 5,
            ),

            SizedBox(height: 30),

            // #. 등록버튼
            OutlinedButton(
                onPressed: todoSave,
                child: Text("할일등록")
            )

          ],
        ),

      ),
    );
    
  }
}
