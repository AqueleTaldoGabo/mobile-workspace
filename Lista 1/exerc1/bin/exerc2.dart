import 'package:exerc1/exerc2.dart' as exerc2;
import 'dart:io';

void main(List<String> arguments) {
  print('Insira um numero:');
  int a = int.parse(stdin.readLineSync()!);
  print('O numero $a é ${exerc2.parOuimpar(a)}');
}