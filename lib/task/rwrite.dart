
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Rwrite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RwriteState();
  }
}

class _RwriteState extends State<Rwrite>{
  TextEditingController rcontent = TextEditingController();
  TextEditingController rpwd = TextEditingController();
  
  Dio dio = Dio();
  
  // [1] 매개변수가져오기
  int bno = 0;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bno = ModalRoute.of(context)!.settings.arguments as int;
    
  }
  
  // [1] 리뷰등록
  void saveReview( int bno) async{
    try{
      final sendData = {
        "rcontent" : rcontent.text,
        "rpwd" : rpwd.text,
        "bno" : bno
      };
      final response = await dio.post("http://192.168.40.34:8080/task/review", data: sendData);

      if(response != null){
        Navigator.pushNamed(context, "/");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("리뷰 등록 페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("리뷰를 등록하세요."),
            SizedBox(height: 30),
            TextField(
              controller: rcontent,
              decoration: InputDecoration(labelText: "리뷰내용"),
              maxLength:  30,
            ),

            SizedBox(height: 30),

            TextField(
              controller: rpwd,
              decoration: InputDecoration(labelText: "비밀번호"),
              maxLines: 5,
            ),

            SizedBox(height: 30),

            // #. 등록버튼
            OutlinedButton(
                onPressed: () => {saveReview(bno)},
                child: Text("리뷰등록")
            )

          ],
        ),

      ),
    );

  }
}

