
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  Dio dio = Dio();

  List<dynamic> list = [];

  // [1] 전체 조회
  void findAll() async{
    try{
      final response = await dio.get("http://192.168.40.34:8080/day04/task");
      
      setState(() {
        list = response.data;
      });
      
      print(list);
      
    }catch(e){
      print(e);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findAll();
  }

  // [2] 삭제
  void delete(id) async {
    try{
      final response = await dio.delete("http://192.168.40.34:8080/day04/task?id=${id}");

      if(response.data == true){
        findAll();
      }

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지"),),
      body: Center(
        child: Column(
          children: [
            // # 등록으로 이동
            TextButton(
                onPressed: () => {Navigator.pushNamed(context, "/write")},
                child: Text("비품 등록")
            ),
            
            SizedBox(height: 10,),
            
            Expanded(
                child: ListView(
                  children: 
                    list.map((i) {
                      return Card(child: ListTile(
                        title: Text(i['name']),
                        subtitle: Column(
                          children: [
                            Text("설명 : ${i['description']}"),
                            Text("수량 : ${i['quantity']}")
                          ],
                        ),

                        trailing: Row(
                          mainAxisSize:  MainAxisSize.min,
                          children: [
                            // # 수정페이지 버튼
                            IconButton(
                                onPressed: () => {Navigator.pushNamed(context, "/update", arguments: i['id'])},
                                icon: Icon(Icons.edit)
                            ),
                            // # 상세페이지 버튼
                            IconButton(
                                onPressed: () => {Navigator.pushNamed(context, "/detail", arguments: i['id'])},
                                icon: Icon(Icons.info)
                            ),
                            // # 삭제버튼
                            IconButton(
                                onPressed: () => {delete(i['id'])},
                                icon: Icon(Icons.delete)
                            )
                          ],
                        ),
                      ),
                      );
                    }).toList(),
                ) 
            )
          ],
        ),
      ),
    );
  }
}