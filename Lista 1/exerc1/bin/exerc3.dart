import 'package:exerc1/exerc3.dart' as exerc3;
import 'dart:io';

void main(List<String> arguments) {
  print('Insira 3 numero:');
  int a = int.parse(stdin.readLineSync()!);
  int b = int.parse(stdin.readLineSync()!);
  double c = double.parse(stdin.readLineSync()!);
  print('O resultado da soma modificada é ${exerc3.somaComplicada(a, b, c)}');

}