void main(){
  // [1] +
  int a1 = 2;
  int b1 =1;
  print(a1 +b1);

  String firstName = 'Jeongjoo';
  String lastName = 'Lee';
  String fullName = lastName + '' + firstName;

  // [2] -
  int a2 = 2;
  int b2 = 1;
  print(a2 - b2);

  // [3] -표현식 : 부호를 뒤집음 ( 양수 -> 음수 / 음수 -> 양수)
  int a3 = 2;
  print(-a3);

  // [4] *
  int a4 = 6;
  int b4 = 3;
  print(a4 * b4);

  print("*" * 5);

  // [5] /
  int a5 = 10;
  int b5 = 4;
  print(a5 / b5);

  // [6] ~/
  int a6 = 10;
  int b6 = 4;
  print(a6 ~/ b6);

  // [7] %
  int a7 = 10;
  int b7 = 4;
  print(a7 % b7);

  // [8] ++변수
  int a8 = 0;
  print(++a8);
  print(a8);

  // [9] 변수++
  int a9 = 0;
  print(a9++);
  print(a9);

  // [10] --변수
  int b10 = 1;
  print(--b10);
  print(b10);

  // [11]  변수--
  int b11 = 1;
  print(b11--);
  print(b11);

  // [12] ==
  int a12 = 2;
  int b12 = 1;
  print(a12 ==b12);

  // [13] !=
  int a13 = 2;
  int b13 = 1;
  print(a13 != b13);

  // [14] >
  int a14 = 2;
  int b14 = 1;
  print(a14 > b14);

  // [15] <
  int a15 = 2;
  int b15 = 1;
  print(a15 < b15);

  // [16] >=
  int a16 = 2;
  int b16 = 1;
  print(a16 >= b16);

  // [17] <=
  int a17 = 2;
  int b17 = 2;
  print(a17 <= b17);

  // [18] =;
  int a18 = 1;
  print(a18);

  a18 = 2;
  print(a18);

  // [19] += , -=, *=
  a18 * 3;
  a18 = a18 * 3;

  // [20] !표현식
  int a20 = 2;
  int b20 = 1;
  bool result = a20 > b20;
  print(!result);

  // [21] ||
  int a21 = 3;
  int b21 = 2;
  int c21 = 1;
  print(a21 > b21);
  print(b21 < c21);
  print(a21 > b21 || b21 < c21);

  // [22] &&
  int a22 = 3;
  int b22 = 2;
  int c22 = 1;
  print(a22 > b22);
  print(b22 < c22);
  print(a22 > b22 && b22 < c22 );

}