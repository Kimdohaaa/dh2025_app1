void main(){
  // *** p.73 ~ p.84 *** //
  // [1] if-else
  int number1 = 31;
  if(number1 % 2 == 1){
    print("홀수");
  }else{
    print("짝수");
  }

  // [2] if-else if-else
  String light2 = "red";
  if(light2 == "green"){
    print("초록불");
  }else if(light2 == "yellow"){
    print("노란불");
  }else if(light2 == "red"){
    print("빨간불");
  }else{
    print("잘못된 신호입니다.");
  }

  // [3] if-else if
  String light3 = "red";
  if(light3 == "green"){
    print("초록불");
  }else if(light3 == "yellow"){
    print("노란불");
  }else if(light3 == "red"){
    print("빨간불");
  }

  // [4] for
  for(int i = 0; i < 100 ; i++){
    print(i + 1);
  }

  // [5] for-in
  List<String> subjects5 = ["자료구조", "이산수학", "알고리즘", "플러터"];
  for(String subject5 in subjects5){
    print(subject5);
  }

  // [6] while
  int i6 = 0;
  while(i6 < 100){
    print(i6 + 1);
    i6 = i6 + 1;
  }

  // [7] while
  // int i7 = 0;
  // while(true){
  //   print(i7 + 1);
  //   i7 = i7 + 1;
  // }

  // [8] while-break
  int i8 = 0;
  while(true){
    print(i8 + 1);
    i8 = i8 + 1;
    if(i8 == 100){
      break;
    }
  }

  // [9] if-continue
   for(int i = 0; i < 100; i++){
     if(i % 2 == 0){
       continue;
     }
     print(i + 1);
   }

   // [10]
   int number10 = add(1, 2);
   print(number10);


   // [11] switch
   switch(number10){
     case 1 :
       print("one");
   }

   // [12] 패턴매칭 switch

   const a12 = 'a';
   const b12 = 'b';
   const obj = [a12, b12];
   switch(obj){
     case[a12,b12] :
       print('$a12, $b12');
   }

   // [13] switch
 const obj13 = 3;
  switch(obj13) {
    case 1 :
      print("one");
    case >= 1 && <= 2 :
      print('in range');
    case (var a, var b) :
      print('a = $a , b = $b');
    default :

  }
}
// [10]
int add(int a10 , int b10){
  return a10 + b10;
}