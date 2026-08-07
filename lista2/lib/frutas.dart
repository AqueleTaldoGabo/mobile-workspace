import 'dart:ffi';

List<String> frutasLista() {
  return ["Banana", "Maça", "Tomate", "Pera", "Uva"];
}
void printar(List<String> frutas){
  for(String fruta in frutas){
    print(fruta);
  }
}
void printarPos(int i, List<String> frutas) => print(frutas[i]);


void printarLoopNum(List<String> frutas){
  for (int i = 0; i< frutas.length; i++){
    print(frutas[i].toUpperCase());
  }
}

void printarLoopEach(List<String> fruta) => fruta.forEach((fruta) {print(fruta.toLowerCase()); } );

List<String> frutasComX(String x, List<String> frutas){
  List<String> frutasCom = frutas.where((i) => i.startsWith(x)).toList();
  return frutasCom;
}