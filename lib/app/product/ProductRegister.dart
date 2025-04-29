import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRegister extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductRegisterState();
  }
}

class _ProductRegisterState extends State<ProductRegister>{
  Dio dio = Dio();
  String baseUrl = "http://192.168.40.34:8080";
  List<dynamic> categoryList = [];

  final TextEditingController pnameController = TextEditingController();
  final TextEditingController pcontentController = TextEditingController();
  final TextEditingController ppriceController = TextEditingController();
  int? cno = 1;

  // [*] 페이지 오픈 시 실행
  @override
  void initState() {
    onCagtegory();
  }

  // [*] 이미지 피커
  List<XFile> selectedImage = [];
  void onSelectImage() async{
    try{
      // 1) 이미지 피커 객체 생성
      ImagePicker picker = ImagePicker();
      // 2) 사용자가 선택한 이미지 XFile 로 반환
      List<XFile> pickedFile = await picker.pickMultiImage();
      // 3) 선택한 이미지가 존재 시 상태 변수에 대입
      if(pickedFile.isNotEmpty){
        setState(() {
          selectedImage = pickedFile;
        });
      }
    }catch(e){
      print(e);
    }
  }
  // [*] 카테고리 조회 함수
  void onCagtegory() async{
    try{
      final response = await dio.get("$baseUrl/product/category");
      if(response.data != null){
        setState(() {
          categoryList = response.data;
        });
        print(categoryList);
      }
    }catch(e){
      print(e);
    }
  }
  // [*] 제품 등록 요청 함수 (FormData)
  void onRegister() async{
    try{
      // 1) 현재 로그인된 토큰 확인
      final prefs = await SharedPreferences.getInstance(); // 전역변수 객체 호출
      final token = prefs.getString("token"); // 전역변수 객체에 저장된 key 값 호출
      if( token == null ){ print("로그인후 가능합니다."); return; } // 비로그인 상태

      // 2) 서버로 보낼 FormData
      FormData formData = FormData(); // 전송할 자료를 바이너리(바이트)타입으로 변경
                                      // => 첨부파일이 대용량이기 때문
      formData.fields.add( MapEntry("pname", pnameController.text  ));      // 폼에 입력받은 제품명 대입
      formData.fields.add( MapEntry("pcontent", pcontentController.text )); // 폼에 입력받은 제품설명 대입
      formData.fields.add( MapEntry("pprice", ppriceController.text ) );    // 폼에 입력받은 제품가격 대입
      formData.fields.add( MapEntry("cno", '${cno}' ) );                    // 폼에 입력받은 카테고리번호 대입
      // 사용자가 선택한 이미지를 파일 객체로 생성
      for(XFile image in selectedImage){
        // MultipartFile : Dio 에서 제공
        final file = await MultipartFile.fromFile(image.path, filename: image.name); // 파일경로와 파일명
        formData.files.add(MapEntry("files", file)); // 폼에 입력받은 이미지 대입
        // XFile 타입으로는 전송 불가하기때문에 MultipartFile 로 변환하여 백으로 전송 //
      }

      // 3) Dio 요청
      dio.options.headers['Authorization'] = token;  // 3-1 : HTTP Header( 통신 정보 )에 인증 정보 포함.
      final response = await dio.post("$baseUrl/product/register" , data : formData );

      if(response.statusCode == 200 && response.data == true){
        print("제품 등록 성공");
      }

      // 4) Dio 응답 처리
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    // + 카테고리 드롭다운 위젯 함수
    Widget CategoryDropdown(){
      // return DropdownButton( items : items , onChanged: onChanged );
      // items : 드롭다운 안에 들어가는 여러개의 항목들
      // 리스트.map( (반복변수){ return } ).toList()
      // onChanged : 드롭다운 값의 선택이 변경 되었을때 이벤트 발생함수.
      return DropdownButtonFormField( // 제네릭 <int> : value 에 들어가는 값 타입
          value: cno, // 카테고리 번호 초기값
          hint: Text("카테고리 선택") , // 가이드라인
          decoration: InputDecoration( border: OutlineInputBorder() ), // 바깥 테두리
          items: categoryList.map( (category){
            return DropdownMenuItem<int>( // 제네릭 <int> : value 에 들어가는 값 타입
              value: category['cno'],  // 드롭다운에서 값 선택시 반환되는 값
              child: Text( category['cname'] ) ,  // 드롭다운 화면에 보이는 텍스트
            );
          }).toList(),
          onChanged: ( value ){ setState(() { cno = value;  });} // 변경된/선택된 값을 cno에 대입
      );
    }

    // (+) 선택한 이미지를 미리보기 제공 함수
    Widget ImagePreview(){
      if( selectedImage.isEmpty ){ return SizedBox(); }//만약에 선택된 이미지가 없으면 빈칸
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal , // List 방향 , 기본값이 세로 , 가로 설정
          itemCount: selectedImage.length, // 이미지 개수만큼 반복
          itemBuilder: (context, index){ // 반복문
            final XFile xFile = selectedImage[index]; // index 번째 xfile 꺼내기
            return Padding(
              padding: EdgeInsets.all(5), // 여백
              child: SizedBox(
                width: 100, height: 100 ,  // 이미지 사이즈 설정
                child: Image.file( File( xFile.path ) ), // 현재 index번째의 xfile 경로를 이미지로 출력
              ),
            );
          },
        ) ,
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all( 20 ),
        child: Column(
          children: [

            CategoryDropdown(),
            SizedBox( height: 10 , ),

            TextField(
              controller: pnameController,
              decoration: InputDecoration( labelText: "제품명" , border: OutlineInputBorder() ),
            ) ,
            SizedBox( height: 10 , ),

            TextField(
              controller: pcontentController,
              maxLines: 3 , // 텍스트 줄 길이
              decoration: InputDecoration( labelText: "제품 설명" , border: OutlineInputBorder() ),
            ) ,
            SizedBox( height: 10 , ),

            TextField(
              controller: ppriceController,
              decoration: InputDecoration( labelText: "제품 가격" , border: OutlineInputBorder() ),
              keyboardType: TextInputType.number, // 키보드 기본 타입을 설정
            ) ,
            SizedBox( height: 10 , ),
            TextButton.icon(
              icon: Icon( Icons.add_a_photo ),
              label: Text("이미지 선택 : ${ selectedImage.length }개 "),
              onPressed: onSelectImage,
            ),
            ImagePreview(),
            SizedBox( height: 10 , ),
            ElevatedButton(onPressed: onRegister, child: Text("제품등록") ),
          ], // c end
        ),// c end
      ), // c end
    ); // Scaffold end
  }
}