// signup.dart : 회원가입 페이지 파일

import 'package:dh2025_app1/app/layout/myapp.dart';
import 'package:dh2025_app1/app/member/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup>{
  Dio dio = Dio();

  // [#] 입력 컨트롤러
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // [#] 등록버튼 이벤트 함수
  void onSignup() async{
    final sendData = {
      "email" : emailController.text,
      "pwd" : emailController.text,
      "name" : nameController.text
    };

    // [*] Rest API 통신 간의 로딩화면 표시
    // showDialog() : 로딩화면을 표시하는 위젯
    // CircularProgressIndicator() : 로딩 화면 아이콘 위젯
    showDialog(context: context,
      builder: (context) => Center(child: CircularProgressIndicator(),),
      barrierDismissible: false, // 로딩 시 팝업창(로딩화면) 외 클릭 차단
    );

    try{

      final response = await dio.post("http://192.168.40.34:8080/member/signup", data: sendData);

      // Navigator.pop(context) : 위젯 트리에서 가장 최근에 열린 위젯을 닫음 -> 팝업
      Navigator.pop(context); 
      // -> 없으면 실패 시에도 계속 진행됨
      if(response.data){
        print("true");
        // 성공 시 알림 메세지 출력
        Fluttertoast.showToast(msg: "회원가입 성공",
          toastLength: Toast.LENGTH_LONG, // 메세지 유지 시간
          gravity: ToastGravity.CENTER, // 메세지 출력 위치
          timeInSecForIosWeb: 3, // 유지시간 지정(sec)
          backgroundColor: Colors.black, // 배경 색상 지정
          textColor: Colors.white, // 글자 색상 지정
          fontSize: 15, // 글자 크기 지정
        );

        // 회원가입 성공 시 페이지 전환
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Login())
        );
      }else{
        print("회원가입 실패");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container( // Container( padding :  , margin : ); 안쪽/바깥 여백 위젯
          padding : EdgeInsets.all( 30 ), // EdgeInsets.all() : 상하좌우 모두 적용되는 안쪽 여백
          margin : EdgeInsets.all( 30 ) , // EdgeInsets.all() : 상하좌우 모두 적용되는 바깥 여백
          child: Column( // 세로배치 위젯
            mainAxisAlignment: MainAxisAlignment.center, // 주 축으로 가운데 정렬( Column 이면 세로 , Row이면 가로 )
            children: [ // 하위 위젯
              TextField(
                controller: emailController,
                decoration: InputDecoration( labelText: "이메일", border: OutlineInputBorder() ),
              ), // 입력 위젯 , 이메일(id)
              SizedBox( height: 20, ),
              TextField(
                controller: pwdController,
                obscureText: true, // 입력한 텍스트 가리기
                decoration: InputDecoration( labelText: "비밀번호" , border: OutlineInputBorder() ),
              ), // 입력 위젯 , 패드워드
              SizedBox( height: 20, ),
              TextField(
                controller: nameController,
                decoration: InputDecoration( labelText: "닉네임" , border: OutlineInputBorder() ),
              ), // 입력 위젯 , 닉네임
              SizedBox( height: 20, ),
              ElevatedButton( onPressed: onSignup , child: Text("회원가입") ),
              SizedBox( height: 20, ),
              TextButton( onPressed: ()=>{
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=> Login() )
                )
              }, child: Text("이미 가입된 사용자 이면 _로그인") )
            ],
          ) ,
        )
    ) ;
  } // build end
} // class end