import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// [1] 상태 관리 클래스
class Detail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

// [2] 상태 사용 클래스
class _DetailState extends State<Detail> {
  TextEditingController bpwdController = TextEditingController();

  Map<int, TextEditingController> rpwdController = {};
  TextEditingController getRpwdController(int rno) {
    // Map 의 TextEditingController 값 반환
    return rpwdController.putIfAbsent(rno, () => TextEditingController());
  }
  Dio dio = Dio();
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

      setState(() {
        book = response.data;

        findByBname();
      });
    }catch(e){
      print(e);
    }
  }
  
  // [3] 책 추천 삭제
  void deleteBook(int bno) async{
    try{
      String bpwd = bpwdController.text;
      final response = await dio.delete("http://192.168.40.34:8080/task/book?bno=$bno&bpwd=$bpwd");

      if(response.data == true){
        Navigator.pushNamed(context, "/");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("비밀번호를 확인하세요.")),
        );
        return;
      }
    }catch(e){
      print(e);
    }
  }

  // [4] 리뷰 출력
  List<dynamic> reviewList = [];
  void findByBname() async{
    try{
      String bname = book['bname'];
      final response = await dio.get("http://192.168.40.34:8080/task/review?bname=$bname");

      setState(() {
        reviewList = response.data;
      });

      print(reviewList);
    }catch(e){
      print(e);
    }
  }

  // [5] 리뷰 삭제
  void reviewDelete(int rno,) async{
    try{
      String rpwd = getRpwdController(rno).text;

      final response = await dio.delete("http://192.168.40.34:8080/task/review?rno=$rno&rpwd=$rpwd");

      if(response.data == true) {
        findByBname();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("비밀번호를 확인하세요.")),
        );
        return;
      }
    }catch(e){
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("책 추천 상세페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("책제목 : ${book['bname']}", style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,),
            Text("저자 : ${book['bwriter']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),
            Text("추천내용 : ${book['bcontent']}", style: TextStyle(fontSize: 13),),
            SizedBox(height: 8,),
            Text("등록날짜 : ${book['createAt']}", style: TextStyle(fontSize: 13),),
            SizedBox(height: 8,),
            Text("수정날짜 : ${book['updateAt']}", style: TextStyle(fontSize: 13),),
            SizedBox(height: 8,),

            TextField(
              controller: bpwdController,
              decoration: InputDecoration(labelText: "비밀번호"),
            ),   
            IconButton(
                onPressed: () => {deleteBook(bno)}, 
                icon: Icon(Icons.delete)
            ),
            IconButton(
                onPressed: () => {Navigator.pushNamed(context, "/rwrite", arguments: bno)},
                icon: Icon(Icons.edit)
            ),
          Expanded(
            child: reviewList.isNotEmpty
                ? ListView(
              children: reviewList.map((r) {
                return Card(
                  child: ListTile(
                    title: Text(r['rcontent'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("등록날짜 : ${r['createAt']}"),
                        Text("수정날짜 : ${r['updateAt']}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: getRpwdController(r['rno']),
                            decoration: InputDecoration(labelText: "리뷰 비밀번호"),
                          ),
                        ),
                        IconButton(
                          onPressed: () => reviewDelete(r['rno']),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                : Center(child: Text("등록된 리뷰가 없습니다.")),
          ),
          ],
        ),
      ),
    );
  }
}