import 'package:lista1/exerc8.dart' as exerc8;
import 'dart:io';

void main(List<String> arguments) {
  print("Insira um numero:");
  int a = int.parse(stdin.readLineSync()!);
  
  print("Fatorial:");
  exerc8.fatorial(a);
}