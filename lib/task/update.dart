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
class _UpdateState extends State<Update> {
  Dio dio = Dio();
  TextEditingController bnameController = TextEditingController();
  TextEditingController bcontentController = TextEditingController();
  TextEditingController bwriterController = TextEditingController();
  TextEditingController bpwdController = TextEditingController();

  // [1] 매개변수 받아오기
  int bno = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bno = ModalRoute.of(context)!.settings.arguments as int;

    findByBno(bno);
  }
  // [2] 책 추천 상세 조회
  Map<String, dynamic> book = {};
  void findByBno(bno) async {
    try{
      final response = await dio.get("http://192.168.40.34:8080/task/book/view?bno=$bno");
      final b = response.data;

      setState(() {
        bnameController.text = b['bname'];
        bwriterController.text = b['bwriter'];
        bcontentController.text = b['bcontent'];
      });
    }catch(e){
      print(e);
    }
  }

  // [3] 책 수정
  void updateBook()async{
    try{
      final sendData = {
        "bname" : bnameController.text,
        "bwriter" : bwriterController.text,
        "bcontent" : bcontentController.text,
        "bpwd" : bpwdController.text,
        "bno" : bno
      };

      final response = await dio.put("http://192.168.40.34:8080/task/book", data: sendData);

      if(response.data == true){
        Navigator.pushNamed(context, "/");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("비밀번호를 확인하세요.")),
        );
        return;
      }
    }catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("책 추천 수정 페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("책제목"),
            TextField(
              controller: bnameController,
              decoration: InputDecoration(labelText: "책제목"),
              maxLength: 30,
            ),

            SizedBox(height: 30,),

            Text("저자"),
            TextField(
              controller: bwriterController,
              decoration: InputDecoration(labelText: "저자"),
              maxLines: 5,
            ),

            SizedBox(height: 30,),

            Text("추천내용"),
            TextField(
              controller: bcontentController,
              decoration: InputDecoration(labelText: "추천내용"),
              maxLines: 5,
            ),

            SizedBox(height: 30,),

            Text("비밀번호확인"),
            TextField(
              controller: bpwdController,
              decoration: InputDecoration(labelText: "비밀번호확인"),
              maxLines: 5,
            ),



            SizedBox(height: 30,),

            // #. 수정버튼
            OutlinedButton(
                onPressed: updateBook,
                child: Text("수정")
            )
          ],
        ),
      ),
    );
  }
}
