import 'package:lista2/frutas.dart' as frutas;
import 'dart:io';

void main(List<String> arguments) {
  List<String> listaFrutas = frutas.frutasLista();
  print("Insira uma letra:");
  String charac="";
  while(charac.isEmpty|| charac.length > 1){
    charac = stdin.readLineSync()!;
  }
  List<String> frutascom = frutas.frutasComX(charac, listaFrutas);
  frutas.printar(frutascom);
}
