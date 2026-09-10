import 'package:lista1/exerc4.dart' as exerc4;
import 'dart:io';

void main(List<String> arguments) {
  print('Insira 3 numero:');
  int a = int.parse(stdin.readLineSync()!);
  int b = int.parse(stdin.readLineSync()!);
  int c = int.parse(stdin.readLineSync()!);
  print('O resultado da ordenação ${exerc4.decrescente(a, b, c)}');

}