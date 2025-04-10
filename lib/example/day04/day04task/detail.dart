
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailState();
  }
}

class _DetailState extends State<Detail>{
  Dio dio = Dio();


  @override
  void didChangeDependencies() {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    find(id);
  }

  // [1] 상세조회
  Map<String, dynamic> result = {};
  void find(id) async{
    try{
      final response = await dio.get("http://192.168.40.34:8080/day04/task/view?id=$id");
      final data = response.data;
      setState(() {
        result = data;
      });

      print(result);
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
            Text("비품명 : ${result['name']}", style: TextStyle(fontSize: 18),),
            SizedBox(height: 8,),
            Text("비품설명 : ${result['description']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),
            Text("비품수량 : ${result['quantity']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),

          ],
        ),
      ) ,
    );
  }
}