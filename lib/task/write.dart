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
class _WriteState extends State<Write> {
  TextEditingController bnameController = TextEditingController();
  TextEditingController bcontentController = TextEditingController();
  TextEditingController bwriterController = TextEditingController();
  TextEditingController bpwdController = TextEditingController();
  
  Dio dio = Dio();
  // [1] 책 등록
  void saveBook() async{
    try{
      final sendData = {
        "bname" : bnameController.text,
        "bwriter" : bwriterController.text,
        "bcontent" : bcontentController.text,
        "bpwd" : bpwdController.text
      };

      final response = await dio.post("http://192.168.40.34:8080/task/book",data: sendData);

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
      appBar:  AppBar(title: Text("책 추천 페이지")),
      body: Center(
        child: Column(
          children: [
            Text("책 추천을 등록하세요."),
            SizedBox(height: 30),
            TextField(
              controller: bnameController,
              decoration: InputDecoration(labelText: "책제목"),
              maxLength:  30,
            ),

            SizedBox(height: 30),

            TextField(
              controller: bwriterController,
              decoration: InputDecoration(labelText: "저자"),
              maxLines: 5,
            ),
            SizedBox(height: 30),

            // #. content 입력받기
            TextField(
              controller: bcontentController,
              decoration: InputDecoration(labelText: "추천내용"),
              maxLines: 5,
            ),
            SizedBox(height: 30),

            // #. content 입력받기
            TextField(
              controller: bpwdController,
              decoration: InputDecoration(labelText: "비밀번호"),
              maxLines: 5,
            ),

            SizedBox(height: 30),

            // #. 등록버튼
            OutlinedButton(
                onPressed: saveBook,
                child: Text("추천등록")
            )

          ],
        ),

      ),
    );

  }
}
