import 'package:lista2/frutas.dart' as frutas;
import 'dart:io';

void main(List<String> arguments) {
  List<String> listaFrutas = frutas.frutasLista();
  List<double> listaVal = [];
  for(int i = 0; i<listaFrutas.length; i++){
    print("Defina valor para: ");
    frutas.printarPos(i, listaFrutas);
    String? input = stdin.readLineSync();
    if (input != null) {
      listaVal.add(double.parse(input));    
    }

  }
  Map<String, double> mapaFrutas = frutas.frutasMapa(listaFrutas, listaVal);
  print(mapaFrutas);
}
