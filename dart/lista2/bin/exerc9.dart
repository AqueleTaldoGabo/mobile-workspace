import 'package:lista2/exerc9.dart' as exerc9;
import 'dart:io';

void main(List<String> arguments) {
  List<int> listaNumeros = [];
  while (true){
    try{
      print("insira numero (digite qualquer coisa que não for um numero pra sair)");
      int input = int.parse(stdin.readLineSync()!);
      listaNumeros.add(input);
    }catch (e){
      break;
    }
  }
  List<int> listaNumerosPares = exerc9.listaPares(listaNumeros);
  print(listaNumerosPares);
}
