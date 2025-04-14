// signup.dart : 회원가입 페이지 파일

import 'package:dh2025_app1/app/layout/myapp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    try{
      final sendData = {
        "email" : emailController.text,
        "pwd" : emailController.text,
        "name" : nameController.text
      };

      print(sendData);

      final response = await dio.post("http://192.168.40.34:8080/member/signup", data: sendData);

      if(response.data != null){
        print("true");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Container : padding, margin 지정 위젯
      Container(
        padding: EdgeInsets.all(50), // 전체 안쪽 여백 50 지정
        margin: EdgeInsets.all(50), // 전체 바깥 여백 50 지정
        child: Column(
          children: [

          // [#] 회원가입 시 사용자에게 입력 받을 창
          // 1) 이메일 입력창
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 30,),

          // 2) 비밀번호 입력창
          TextField(
            controller: pwdController,
            obscureText: true, // 비밀번호이므로 입력값이 안보이도록 설정
            decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 30,),

          // 3) 이름 입력창
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 30,),

          // [#] 회원가입 버튼
          ElevatedButton(
              onPressed: onSignup,
              child: Text("회원가입")
          ),
          SizedBox(height: 10,),

          // [#] 로그인 페이지로 이동 버튼
          TextButton(
              onPressed: (){},
              child: Text("로그인 페이지로 이동")
          )
          ],
        ),
      ),

    );
  }
}
