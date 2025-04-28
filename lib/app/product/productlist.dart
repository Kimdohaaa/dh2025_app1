
import 'package:dh2025_app1/app/product/productview.dart';
import 'package:dh2025_app1/example/day04/day04task/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList>{
  
  // [#] 카테고리 번호를 저장할 변수 선언
  int cno = 0;
  // [#] 현재 조회중인 페이지 번호를 저장하 변수 선언
  int page = 1; // 초기값 1페이지로 지정 (앱이기때문에 페이징 처리 대신 무한스크롤)
  // [#] 자바 서버로 부터 조회한 제품(DTO) 목록 상태변수
  List<dynamic> productList = [];

  // [#] 현재 스크롤의 상태(위치/크기 등)를 감지하는 컨트롤러
  // 무한스크롤 : 스크롤이 거의 바닥에 존재했을 때 새로운 자료 요청 후 추가
  final ScrollController scrollController = ScrollController();

  // [#] 기본 URL => 배포 시 환경에 따라 IP 를 변경해야함
  String baseUrl = "http://192.168.40.34:8080";

  Dio dio = Dio();

  // [1] 자바 서버에게 자료 욫어 => 스크롤 리스너(이벤트) 추가
  @override
  void initState() {
    onProductAll(page); // 페이지 번호 최초 전송
    // .addListener() : 스크롤의 이벤트(함수)리스너 추가
    scrollController.addListener(onScroll);
  }

  // [2] 자바 서버에게 자료 요청
  void onProductAll(int currentPage) async{

    try{
      final response = await dio.get("${baseUrl}/product/all?page=${currentPage}");

      setState(() {
        page = currentPage; // 증가된 현재 페이지를 상태 변수에 반영
        if(page == 1){
          productList = response.data['content'];
        }else if(page = response.data['totalpage']){
          page = response.data['totalpage'];
        }else{
          productList.addAll(response.data['contnet']);
        }
      });

      print(productList);
    }catch(e){
      print(e);
    }
  }

  // [3] 스크롤 리스터(이벤트) 추가 메소드
  void onScroll(){
    // 1) 스크롤의 현재 위치가 거의 끝에 도달했는지 여부 검사
    // .position : 현재 스크롤의 위치 반환
    // .pixels : 픽셀 형태로 반환
    // .maxScrollExtent : 현재 화면의 최대 크기
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 150){
      // 스크롤이 거의 끝에 도달했다면 page + 1을 통해 다음 페이지 자료 요청
      onProductAll(page + 1);

    }
  }
  @override
  Widget build(BuildContext context) {
    // 제품 목록이 존재하지 않으면
    if(productList.isEmpty){
      return Center(child: Text("조회된 제품이 없습니다."),);
    }
    // 제품목록이 존재하면
    // ListView.builder : 여러개의 위젯을 리스트 형식으로 출력하는 우젯
    return ListView.builder(
      controller: scrollController, // ListView 의 스크롤 컨트롤러 연결
        // itemCount : 목록의 항목 개수
        itemCount: productList.length,
        // 목록의 항목 개수만큼 반복
        itemBuilder: (context, index) {
          // 1) 각 index 번째 제품 꺼내기
          final product = productList[index];
          // 2) 아미지 리스트 추출
          final List<dynamic> images = product['images'];
          // 3) 만약 이미지가 존재하면 대표 이미지 1개 추출 없으면 기본 이미지 추출
          String? imageUrl ;
          if(images.isEmpty){ // 리스트가 비어있으면
            imageUrl = "$baseUrl/upload/default.jpg";
          }else{ // 리스트가 비어있지 않으면 첫번째 이미지 추출
            imageUrl = "$baseUrl/upload/${images[0]}";
          }

          // InkWell() : 해당하는 위젯 클릭(탭) 페이지 이동 구현 위젯
          // (4) 위젯
          return InkWell( // 해당 위젯의 하위 위젯을 클릭(탭:모바일 터치) 하면 '상세 페이지'로 이동 구현
              onTap: () => { 
                Navigator.push(context,  // .push : 뒤로 가기 버튼 제공
                MaterialPageRoute(builder: (context) => ProductView(pno : product['pno'])) // ProductView 의 생성자를 통해 pno 전달
                )
              } , // 만약에 하위 위젯(Card) 을 클릭했을때 이벤트 발생
              child: Card(
                margin: EdgeInsets.all( 15 ), // 바깥여백
                child: Padding(
                  padding: EdgeInsets.all( 10 ), // 안쪽여백
                  child: Row(  // 가로 배치 ,
                    children: [ // 가로 배치할 위젯들

                      Container( // 하위요소를 담을 박스(div)
                        width: 100, height: 100, // 가로 세로 사이즈
                        child: Image.network(  // 웹 이미지 출력 ( 이미지 위젯 ),
                          imageUrl , // 이미지 경로
                          fit: BoxFit.cover, ), // 만약에 이미지가 구역보다 크면 비율유지
                      ),

                      SizedBox( width: 20 ,) , // 여백

                      Expanded(child: Column(  // 그외 구역
                        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                        children: [
                          Text( product['pname'] , style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold ), ) ,
                          SizedBox( height: 8,),
                          Text( "가격: ${ product['pprcie'] }" , style: TextStyle( fontSize: 16 , color: Colors.red ), ) ,
                          SizedBox( height: 4,),
                          Text( "카테고리: ${  product['cname'] }" ) ,
                          SizedBox( height: 4,),
                          Text( "조회수: ${ product['pview'] }" ) ,
                        ],
                      )) , // Card의 남은 부분
                    ],
                  ), // Row end
                ), // Card end
              )
          );// InkWell end
        },
    ); // ListView end
  } // build end
} // class end