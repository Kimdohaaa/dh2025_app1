import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login>{
  Dio dio = Dio();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  
  // [#] 로그인
  void onLogin() async{
    try{
      final obj = {
        "email" : emailController.text,
        "pwd" : pwdController.text
      };
      final response = await dio.post("http://192.168.40.34:8080/member/login", data: obj);

      if(response.data != null){
        print("로그인 성공 : " + response.data);
        // *** SharedPreferences *** //
        // [*] 로그인 성공 시 반환된 토큰을 SharedPreferences 에 저장
        // 1) 객체 생성 (!!!SharedPreferences 는 비동기로 동기화 필수!!!)
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // 2) 전역변수에 값 저장 (!!!SharedPreferences 는 비동기로 동기화 필수!!!)
        await prefs.setString("token", response.data);

      }else{
        print("로그인 실패");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        padding: EdgeInsets.all(50),
        margin: EdgeInsets.all(50),
        child: Column(
          children: [
            // [#] 이메일 입력받기
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 30,),

            // [#] 비밀번호 입력받기
            TextField(
              controller: pwdController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 30,),

            // [#] 로그인 버튼
            ElevatedButton(
                onPressed: onLogin,
                child: Text("로그인")
            ),
            SizedBox(height: 30,),
            TextButton(
                onPressed: (){},
                child: Text("비회원-회원가입페이지")
            )
          ],
        ),
      ),
    );
  }
}