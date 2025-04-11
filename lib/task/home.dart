import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 클래스
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

// [2] 상태 사용 클래스
class _HomeState extends State<Home> {
  Dio dio = Dio();

  // [1] 책 추천 등록
  List<dynamic> bookList = [];
  void findAll() async{
    try{
      final response = await dio.get("http://192.168.40.34:8080/task/book");

      setState(() {
        bookList = response.data;
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지"),),
      body: Center(
        child: Column(
          children: [
            // #. 등록 화면으로 이동하는 버튼 //
            TextButton(
                onPressed: () => {Navigator.pushNamed(context, "/write")},
                child: Text("책 추천 등록")),

            SizedBox(height: 30),

            // #. ListView() 위젯을 이용한 할일 목록 출력
            // (1) 자바로부터 가져온 List 를 map 함수를 이용하여 Card 형식의 위젯으로 만든 뒤 출력
            Expanded( // Column() 위젯 내에서 ListView() 위젯사용 시 Expanded() 위젯 안에서 사용해야함
                child: ListView( // 높이 100% 의 자동 세로 스크롤을 지원하는 위젯
                  children: // map() 사용 시 반환값이 List 이기 때문에 대괄호 생략
                  bookList.map((book) {
                    return Card(child: ListTile(
                        title: Text(book['bname']), // 제목 (한 개만 출력 가능)
                        subtitle: Column( // 부제목 (여러개 출력 가능)
                          children: [
                            Text("등록날짜 : ${book['createAt']}"),
                            Text("수정날짜 : ${book['updateAt']}")
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
                                  onPressed: () => {Navigator.pushNamed(context, "/update", arguments: book['bno'])},
                                  icon: Icon(Icons.edit)
                              ),

                              // #. 상세 보기 버튼
                              IconButton(
                                // => 상세보기 버튼 클릭 시 "/detail" 경로로 이동 / 해당 경로에 todoList 의 'id'를 매개변수로 보냄
                                  onPressed: () => {Navigator.pushNamed(context, "/detail", arguments: book['bno'])},
                                  icon: Icon( Icons.info)
                              ),

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
