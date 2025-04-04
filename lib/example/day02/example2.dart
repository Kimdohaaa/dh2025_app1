// Dart : 단일 스레드 기반의 언어
// Dart 라이브러리 다운 홈페이지 : https://pub.dev/packages

// [1] Dio import 하기
import 'package:dio/dio.dart';

// [2] Dio 객체 생성 : final 객체명 = 클래스명();
  // final : 상수 키워드
final dio = Dio(); // 전역 변수로 선언

void main(){ // main 함수가 싱글 스레드를 갖고 코드의 시작점이 됨

  print('>> dart Start');

  // * GET 통신 메소드 호출 * //
  getHttp();

  // * POST 통신 메소드 호출 * //
  postHttp();


}

// [3] HTTP REST 통신 : dio.HTTP메소드명("URL");
// 1) GET 방식 : dio.get("URL");
void getHttp() async { // async 와 await 키워드를 통해 동기화
  try { // *** try-catch 로 예외처리 *** //

    // 1-1) dio 함수를 통해 자바와 통신
    final response
    = await dio.get(
        "http://localhost:8080/day03/task"); // Spring 의 day03/_day03과제와 통신

    // 1-2) 응답 확인
    print(response.data);

  }catch(e){
    print(e);
  }
}
// 2) POST 방식 : dio.post("URL", data: 보낼자료);
void postHttp() async {
  try { // *** try-catch 로 예외처리 *** //

    // 2-1) 보낼 자료
    final sendData = { "cname": "수학"};

    // 2-2) dio 함수를 통해 자바와 통신
    final response
    = await dio.post("http://localhost:8080/day03/task",
        data: sendData); // Spring 의 day03/_day03과제와 통신

    // 2-3) 응답확인
    print(response.data);

  }catch(e){
    print(e);
  }
}

