import 'package:lista1/exerc1.dart' as exerc1;
import 'dart:io';

void main(List<String> arguments) {
  print('Insira 3 valores:');
  int a = int.parse(stdin.readLineSync()!);
  int b = int.parse(stdin.readLineSync()!);
  int c = int.parse(stdin.readLineSync()!);
  print('O resultado da soma ${exerc1.menorQueC(a, b, c)}');
}
