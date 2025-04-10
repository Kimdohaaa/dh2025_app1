
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Write extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WriteState();
  }
}

class _WriteState extends State<Write>{
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Dio dio = Dio();

  // 제품 등록
  void save() async{
    try{
      final sendData= {
        "name": nameController.text,
        "description" : descriptionController.text,
        "quantity" : quantityController.text
      };
      final response = await dio.post("http://192.168.40.34:8080/day04/task",data: sendData);

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
      appBar: AppBar(title: Text("등록페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("비품명 등록"),
            SizedBox(height: 10,),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "비품명"),
            ),

            SizedBox(height: 10,),

            Text("비품설명 등록"),
            SizedBox(height: 10,),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "비품설명"),
            ),

            SizedBox(height:  10,),

            Text("비품수량 등록"),
            SizedBox(height: 10,),

            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: "비품수량"),
            ),
            SizedBox(height: 10,),

            OutlinedButton(
                onPressed: save,
                child: Text("비품등록"))

          ],
        ),
      ),
    );
  }
}