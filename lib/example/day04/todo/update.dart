// update.dart : 수정페이지 화면 //

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 클래스
class Update extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpdateState();
  }
}

// [2] 상태 사용 클래스
class _UpdateState extends State<Update>{
  // [*] 자바와 통신을 위해 Dio 선언
  Dio dio = Dio();

  // [*] 입력 컨트롤러 선언
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  // [*] 완료여부를 저장할 상태변수 선언
  bool done = true;

  // [*] 이전 페이지에서 보낸 인자값 받기
  // => 위젯 트리를 사용하기 위해 initState() 대신 didChangeDependencies() 사용
  int id = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    todoFindById(id);
  }

  // [*] 자바와 통신하여 id에 해당하는 상세정보 요청
  Map<String, dynamic> todo = {}; // 응답 객체를 저장하는 객체 선언
      // JSON 타입의 key 는 무조건 문자열 타입 => String / value 는 다양한 타입 => dynamic
  void todoFindById(int id) async {
    try{

      // 매개변수로 전달받은 id 를 쿼리스트링으로 전달
      final response = await dio.get("https://open-bendite-tjoeun-02a1a58d.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;

      // 응답받은 결과를 상태변수에 대입
      setState(() {
        todo = data;
        // 입력컨트롤러에 초기값 대입
        titleController.text = data['title'];
        contentController.text = data['content'];
        done = data['done'];
      });

      print(todo);
    }catch(e){
      print(e);
    }
  }


  // [*] 자바와 통신하여 id에 해당하는 할일을 수정
  void todoUpdate() async{
    try{
      final obj = {
        "title" : titleController.text,
        "content" : contentController.text,
        "done" : done,
        "id" : id
      };
      final response = await dio.put("https://open-bendite-tjoeun-02a1a58d.koyeb.app/day04/todos", data: obj );
      print(response.data);
      if(response.data != null){
        Navigator.pushNamed(context, "/");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("수정 페이지")),
      body: Center(
        child: Column(
          children: [
            // #. 제목 입력 받기
            Text("제목"),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "할일제목"),
              maxLength: 30,
            ),

            SizedBox(height: 30,),

            // #. 내용 입력 받기
            Text("내용"),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "할일내용"),
              maxLines: 5,
            ),

            SizedBox(height: 30,),

            // #. 완료 여부 입력받기
            Text("완료여부"),
            Switch( // Switch() : ON/OFF 지원
                value: done,
                onChanged: (value)  { // return 생략을 위해 => 생략
                  // 완료여부 변경
                  setState(() {
                    done = value;
                  });
                }
            ),

            SizedBox(height: 30,),

            // #. 수정버튼
            OutlinedButton(
                onPressed: todoUpdate,
                child: Text("수정")
            )
          ],
        ),
      ),
    );
  }
}