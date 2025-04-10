
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateState();
  }
}

class _UpdateState extends State<Update>{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Dio dio = Dio();

  int id = 0;
  @override
  void didChangeDependencies() { // didChangeDependencies() : 부모위젯이 변경 시 실행되는 함수
    id = ModalRoute.of(context)!.settings.arguments as int;

    FindById(id);
    print(id);
  }

  // [1] 상세정보 조회
  Map<String, dynamic> result = {}; // 응답 객체를 저장하는 객체 선언
  void FindById(id) async {
    try{

      // 매개변수로 전달받은 id 를 쿼리스트링으로 전달
      final response = await dio.get("http://192.168.40.34:8080/day04/task/view?id=${id}");
      final data = response.data;

      // 응답받은 결과를 상태변수에 대입
      setState(() {
        nameController.text = data['name'];
        descriptionController.text = data['description'];
        quantityController.text = data['quantity'];
      });

      print(result);
    }catch(e){
      print(e);
    }
  }

  // [2] 수정
  void update() async{
    try{
      final sendData = {
        "id" : id,
        "name": nameController.text,
        "description" : descriptionController.text,
        "quantity" : quantityController.text
      };
      final response = await dio.put("http://192.168.40.34:8080/day04/task", data:  sendData);


      if(response.data == true){
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

            Text("비품명"),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "비품명"),
              maxLength: 30,
            ),

            SizedBox(height: 30,),


            Text("비품설명"),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "비품설명"),
              maxLines: 5,
            ),

            SizedBox(height: 30,),


            Text("비품수량"),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: "비품수량"),
              maxLines: 5,
            ),

            SizedBox(height: 30,),

            // #. 수정버튼
            OutlinedButton(
                onPressed: update,
                child: Text("수정")
            )
          ],
        ),
      ),
    );
  }
}