import 'package:lista1/exerc7.dart' as exerc7;
import 'dart:io';

void main(List<String> arguments) {
  int a = 0;
  do{
    print('Insira um numero de 1 a 10:');
    a = int.parse(stdin.readLineSync()!);
  }while(a<1 || a>10);
  print("Tabuada:");
  exerc7.tabuada(a);
}