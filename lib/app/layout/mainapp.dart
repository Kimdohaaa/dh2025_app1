// mainapp.dart : 레이아웃을 구성하는 파일

import 'package:dh2025_app1/app/member/info.dart';
import 'package:dh2025_app1/app/member/login.dart';
import 'package:dh2025_app1/app/member/signup.dart';
import 'package:flutter/material.dart';

// [*] 상태 관리 위젯 선언
class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

// [*] 상태 사용 위젯 선언
class _MainAppState extends State<MainApp>{

  // [1] 페이지 위젯 리스트 선언 : 여러개의 위젯들을 갖는 리스트
  // => Widget : 여러 위젯들을 상속하는 상위 위젯(클래스)
  List<Widget> pages = [
    Text("홈 페이지"),
    Text("게시물1 페이지"),
    Text("게시물2 페이지"),
    Info() //Text("내정보 페이지"),
  ];

  // [2] 페이지의 상단 제목 리스트 생성
  List<String> pageTitle = [
    '홈',
    '게시물1',
    '게시물2',
    '내정보'
  ];

  // [3] 사용자가 클릭한 페이지 번호를 상태변수에 저장
  int selectedIndex = 0; // 0(== '홈')을 초기값으로 지정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [#] 상단 메뉴
      appBar: AppBar(
        title: Row(
          children: [
            // 이미지 출력 방식
            // 1_로컬이미지(플러터에 업로드된 이미지 출력) : Image(image: AssetImage('로컬이미지경로'))
            /* [로컬이미지 경로 설정 방법]
                -> 일반적인 경로 설계 : 프로젝트 -> assets-> images -> 실제이미지파일

                -> pubspec.yaml 파일
                      flutter:
                            assets:
                              - assets/images 로 이미지 겯로 설정

                -> pubspec.yaml 파일 상단의 pub get 을 클릭하여 build 하기
             */

            // 2_네트워크이미지(자바에 업로드된 이미지 출력)

            // #. 로컬이미지 방식으로 이미지 출력
            Image(
              image: AssetImage('assets/images/logo.jpg'), // 로컬이미지 : Image(image: AssetImage('로컬이미지경로'))
              height: 50, // 이미지 세로 크기
              width: 50, // 이미지 가로 크기
            ),
            Text(pageTitle[selectedIndex]),
          ]
        ),
        // 백그라운드 색상 구성 지정
        backgroundColor: Colors.white,
      ),

      // [#] 본문 메뉴
      body: pages[selectedIndex], // 현재 선택된 인덱스에 해당하는 위젯을 보여줌
      

      // [#] 하단 메뉴
      bottomNavigationBar: BottomNavigationBar(
        // #. currrentIndex : 사용자가 선택한 버튼 번호
        currentIndex: selectedIndex,
        // #. onTab : 버튼 위젯(BottomNavigationBarItem)들을 클릭했을 때 발생하는 이벤트 속성
        onTap: (index) => setState(() { // index : 선택된 items 의 index 번호를 반환함
          selectedIndex = index; // 반환된 index 를 위에 선언해놓은 상태변수에 대입
        }),
        // #. 고정 크기 설정 => 4개 이상일 경우 아이콘이 움직이기 때문에 지정
        type:  BottomNavigationBarType.fixed,
        // #. items : 여러개의 버튼 위젯들
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시물1'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시물2'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보(회원가입)'),
        ],
      ),
    );
  }
}