import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget{
  // [#] 필드 (== 멤버변수)
  int? pno ;
  String? pname;
  // [#] 생성자 => 플러터는 오버로딩을 지원하지 않기 때문에 여러개의 생성자 선언 불가
  // (1) 1개의 필드를 갖는 생성자
  // ProductView(this.pno);
  // (2) 여러개의 필드를 갖는 생성자({}(중괄호)를 통해 여러개의 매개변수 받기)
  ProductView({this.pno, this.pname});

  @override
  State<StatefulWidget> createState() {
    print(pno);
    return _ProductViewState();
  }
}

class _ProductViewState extends State<ProductView>{
  Map<String , dynamic> product = {};
  Dio dio = Dio();
  String baseUrl = "http://192.168.40.34:8080";

  // [#] 생명주기
  @override
  void initState() {
    onView();
  }

  // [#] pno 에 해당하는 제품 정보 요청
  void onView() async{
    try{
      // widget.XXX(== 자바의 .super()) : 상위(부모) 위젯 -> ProductView 의 멤버변수
      final response = await dio.get("$baseUrl/product/view?pno=${widget.pno}");

      if(response.data != null) {
        setState(() {
          product = response.data;
        });
      }
     print(product);
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    // [#] 만약 제품 정보가 없으면 로딩
    if(product.isEmpty){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    
    // [#] 이미지 가져오기
    final List<dynamic> images = product['images'];
    // [#] 이미지 상태에 따라 위젯 만들기
    Widget Img;
    if(images.isEmpty){ // 이미지가 존재하지 않으면
      Img = Container(
        height: 300,
        alignment: Alignment.center,
        child: Image.network("$baseUrl/upload/default.jpg", fit: BoxFit.cover),
      );
    }else{ // 이미지가 존재하지 않으면
      Img = Container(
        height:  300,
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder : (context, index){
            String imageUrl = "$baseUrl/upload/${images[index]}";
            return Padding(
              padding: EdgeInsets.all(15),
              child: Image.network(imageUrl, fit : BoxFit.cover),
            );
          }
        ),
      );
    }

    
    return Scaffold(
      appBar: AppBar(title: Text("제품상세페이지"),),
      // SingleChildScrollView() : 만약 내용이 길어지면 스크롤을 제공하는 위젯
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽정렬
          children: [
            // [#] 이미지 출력
            Img,
            Text( product['pname'] , style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold), ) ,
            SizedBox( height: 18,),
            Text( "${product['pprcie']}원" , style: TextStyle( fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.red ), ) ,
            SizedBox( height: 10 ,),
            Divider(), // 구분선 : vs <hr/>
            SizedBox( height: 10,),
            Row( // 가로 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
              children: [
                Text( "카테고리: ${product['cname']}" ) ,
                Text( "조회수: ${product['pview']}" ) ,
              ],
            ),
            SizedBox( height:  10 ,),
            Text( "판매자: ${ product['memail']}" ) ,
            SizedBox( height:  20 ,),
            Text("제품 설명" , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ),),
            SizedBox( height:  8 ,),
            Text( product['pcontent'] ) ,
          ],
        ),
      ) ,
    );
  }
}