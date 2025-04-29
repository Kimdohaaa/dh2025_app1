import 'package:dh2025_app1/app/product/productlist.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // [#] 작성자를 확인할 변수 선언
  bool? isOwner = false;

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
        // (*) 현재 로그인된 회원이 작성한 게시물인지 확인
        // 1) 토큰 가져오기
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if( token == null ){
          setState(() {
            isOwner = false;
          });
        }

        // 2) 해당 토큰의 회원정보 조회
        dio.options.headers['Authorization'] = token;
        final response2 = await dio.get("$baseUrl/member/info");

        // 3) 반환받은 회원정보와 게시물의 회원정보가 같으면 상태변수 true 로 변경
        if(response2.data['email' == response2.data['emaill']] ){
          setState(() {
            isOwner = true;
          });
        }


        setState(() {
          product = response.data;
        });
      }
     print(product);
    }catch(e){
      print(e);
    }
  }

  // [#] 제품 삭제
  void deleteProduct(int pno) async{
    try{
      // 1) 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      dio.options.headers['Authorization'] = token;
      final response = await dio.delete("$baseUrl/product?pno=$pno");

      if(response.data == true ){
        print("제품 삭제 성공");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
      }else{
        print("제품삭제 실패");
      }

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
          scrollDirection: Axis.horizontal, // 목록 스크롤 반환
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
            Text( "판매자: ${ product['email']}" ) ,
            SizedBox( height:  20 ,),
            Text("제품 설명" , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ),),
            SizedBox( height:  8 ,),
            Text( product['pcontent'] ) ,
            SizedBox(height: 20,),

            // [*] 현재 로그인된 회원과 해당 게시물을 작성한 회원이 같다면 tnwjd,삭제버튼 활성화
            if(isOwner != null && isOwner == true)
              Row(children: [
                ElevatedButton(
                    onPressed: (){},
                    child: Text("수정")
                ), ElevatedButton(
                    onPressed: () {deleteProduct(product['pno']);},
                    child: Text("삭제")
                ),
              ],)

          ],
        ),
      ) ,
    );
  }
}