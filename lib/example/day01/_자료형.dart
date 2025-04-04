// * Dart 프로그램 진입점 함수 : main * //
// => 형식 : void main(){}

// * 실행 : ctrl + shift + f10 * //

void main() {
  print("Hello, World!");

  // *** 기본 타입 p.64 *** //
  // [1] 문자열 타입
  // 1) "" 로 문자열 선언 가능
  String name1 = "유재석";
  print(name1);

  // 2) '' 로 문자열 선언 가능
  String name2 = '유재석';
  print(name2);

  // 3) $ 를 통해 변수 사용 가능
  String name3 = "이름 : $name1";
  print(name3);

  // [2] 숫자 타입
  // 1) int 타입 : 정수형
  int year1 = 2023;
  print(year1);

  // 2) double 타입 : 실수형
  double pi1 = 3.14159;
  print(pi1);

  // 3) num 타입 : 정수형 + 실수형
  num year2 = 2023; // 정수 대입 가능
  print(year2);
  num pi2 = 3.14159; // 실수 대입 가능
  print(pi2);

  // [3] 불 타입
  // 1) bool 타입
  bool darkMode = false;
  print(darkMode);

  // *** 컬렉션 프레임워크 p.65 *** //
  // [1] List 타입 (중복 가능 => 인덱스가 있기 때문에 중복값이 생겨도 인덱스로 구분)
  List<String> fruits = ['사과', '딸기', '샤인머스켓'];
  print(fruits);
  print(fruits[2]); // 인덱스 별로 원소 출력 가능
  print(fruits.length); // List 길이 확인 가능

  // [2] Set타입 (중복 불가 => 인덱스가 없기 때문)
  Set<int> odds = {1,3,5,7,9};
  print(odds);

  // [3] Map 타입 (key 와 value 의 entry 로 구성 / key 중복 불가 | value 중복 가능)
  // 자바와 다르게 제네릭에서 기본타입 사용 가능
  Map<String, int> regionMap = {"서울" : 0, "인천" : 1, "대전" : 2};
  print(regionMap);
  print(regionMap['서울']); // key 를 통해 value 출력 가능

  // *** 기타 타입 p.65 ***//
  // [1] Object 타입 : 모든 다트 타입의 최상위 타입 (형변환 필요)
  Object a = 1;
  print(a);
  Object b = 3.14159;
  print(b);
  Object c = "강호동";
  print(c);

  // [2] dynamic 타입 : 동적 타입으로 대입되는 순간 타입 결정 (형변환을 하지 않아도 됨)
  dynamic i1 = 1;         // int 타입
  dynamic i2 = 3.14159;   // double 타입
  dynamic i3 = "강호동";   // 문자열 타입
  dynamic i4 = ['사과'];   // List 타입
  dynamic i5 = {1, 3, 4}; // Set 타입
  dynamic i6 = {"name" : "유재석" , "age" : 40}; // Map 타입

  // ★ 다트는 null이 될 수 있는 변수와 없는 변수를 철저하게 구분함 (null 안정성) ★ //
  String? nickname = null; // ? 를 통해 null 이 될 수 있는 변수를 지정 => null 안정성 보장
  // ? 를 선언하지 않으면 null 대입 불가


  // *** var p.66 *** //
  // var : 처음에 할당된 값의 타입이 결정 (중간에 타입 변경 불가능)
  // dynamic : 선언된 변수는 모든 타입들을 대입 가능 (중간에 타입 변경 가능)





////////////////////////////////////////////////////////////////////////////

  // * 레코드 * //
  // 레코드 == 튜플 == 값의 묶음 == 집합
  /*
   [레코드의 특징]
   1. 익명 : 레코드에 속한 값은 key 부여 여부 선택 가능
   2. 레코드의 값은 불변(변경/삭제 불가)
   3. 컬렉션 처럼 사용 가능
   4. 레코드의 구조 자체가 하나의 타입이 됨
   5. 구조분해 할당 가능 p. 69
  */
  // [1] 레코드 생성
  // 방법_1) var 레코드명 = (원하는 컬렉션 타입);
  var record1 = ('first', a : 2 , b : true, 'last');
  print(record1);

  // 방법_2) (타입) 레코드명; 레코드명 = (원하는 컬렉션 타입);
  (String, int) record2;
  record2 = ('유재석', 40);
  print(record2);

  // [2] 레코드의 값 호출
  print(record1.$1); // 레코드명.$번호 : key 가 존재하지 않는 번호번째 value 반환 => "first"
  print(record1.a);  // 레코드명.key : key 에 해당하는 값 반환 => 2
  print(record1.b);  // => true
  print(record1.$2); // => 'last'

  // [*] JSON 형식 레코드
  var json = {"name" : "Dash", "age" : 10, "color" : "blue"};
  print(json);


}


