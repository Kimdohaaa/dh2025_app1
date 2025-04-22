import 'package:dh2025_app1/app/layout/mainapp.dart';
import 'package:dh2025_app1/app/member/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InfoState();
  }
}

class _InfoState extends State<Info>{
  Dio dio = Dio();

  int mno = 0; // 30;
  String memail = ""; //"qwe@qwe.com";
  String mname = ""; // "유재석";

  // *** SharedPreferences *** //
  // [*] 해당 위젯이 열렸을 때 SharedPreferences를 통해 로그인 여부 확인
  @override
  void initState() {
    loginCheck();
  }
  // [#] 로그인 상태를 확인하는 함수
  // [*] 로그인 상태를 저장할 bool 타입 변수 선언
  bool? isLogin; // Dart 에서 타입 뒤에 ? 사용 시 null 허용
  void loginCheck() async{
    // 1) SharedPreferences 전역변수 가져오기
    final prefs = await SharedPreferences.getInstance();
    // 2) 가져온 전역변수 변수에 담아주기
    final token = prefs.getString("token")?? '';
    // 3) 로그인 여부 확인
    if(token != null && token.isNotEmpty){ // 전역변수에 토큰이 존재하면
      print("로그인중");
      setState(() { // setState 를 통해 로그인 상태 렌더링
        isLogin = true;
        // 로그인 중이면 서버에게 내 정보 요청
        onInfo(token);
      });
    }else{ // setState 를 통해 로그인 상태 렌더링
      print("비로그인중");

      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => 이동할위젯명()) ★ 해당 방법 이용 시 이전 페이지로 이동 불가
        MaterialPageRoute(builder: (context) => Login())
      );
    }
  }

  // [#] 서버로부터 내 정보 반환받기
  void onInfo(String token) async {
    try{
      // [*] Options : DIO 에서 Header 정보를 보내기
      // 방법_1
      dio.options.headers['Authorization'] = token; // 헤더에 토큰 전달
      // 방법_2 : dio.HTTP메소드("경로", options : {headers : {'속성명" : 값}})

      final response = await dio.get("http://192.168.40.34:8080/member/info");

      if(response.data != '' && response.data != null){
        setState(() {
          mno = response.data['mno'];
          memail = response.data['email'];
          mname = response.data['name'];
        });
      }
    }catch(e){
      print(e);
    }
  }

  // [#] 로그아웃
  void logout() async{
    try{
      // 1) 전역 변수로 저장된 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      // 2) 토큰 존재 여부 검사
      if(token == null){ // 토큰이 존재하지 않으면
        return; // 리턴
      }

      // 3) 토큰이 존재하면 서버로 보내기
      dio.options.headers['Authorization'] = token; // 헤더에 토큰 전달
      final response = await dio.get("http://192.168.40.34:8080/member/logout");

      // 4) SharedPreferences 전역변수에 토큰 삭제
      prefs.remove("token");

      print("로그아웃 성공");

      // 5) 로그아웃 성공 시 메인화면으로 이동 (이전페이지로 이동 불가)
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainApp())
      );
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    // [*] 만약에 로그인 상태가 확인되기 전이라면 대기화면 출력
    if(isLogin == null){ // 만약에 비로그인이면
      return Scaffold(
        body: Center(
          // CircularProgressIndicator() : 대기화면(로딩화면)을 제공하는 위젯
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원번호 : $mno"),
            SizedBox(height: 20,),
            Text("회원이메일 : $memail"),
            SizedBox(height: 20,),
            Text("회원이름 : $mname"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: logout, child: Text("로그아웃"))
          ],
        ),
      ),


    );
  }
}