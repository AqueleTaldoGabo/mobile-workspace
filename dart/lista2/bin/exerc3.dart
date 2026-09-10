import 'package:lista2/frutas.dart' as frutas;
import 'dart:io';

void main(List<String> arguments) {
  List<String> listaFrutas = frutas.frutasLista();
  print("Insira uma fruta:");
  String frutaaux = stdin.readLineSync()!;
  listaFrutas.add(frutaaux);
  print("Insira uma fruta pra remover:");
  frutaaux = stdin.readLineSync()!;
  listaFrutas.remove(frutaaux);
  print("");
  frutas.printar(listaFrutas);
}
