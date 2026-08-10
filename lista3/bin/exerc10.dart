import 'package:lista3/iforma.dart' as iforma;

void main(List<String> arguments) {
  iforma.Circulo circulo = iforma.Circulo(raio: 9.1);
  iforma.Retangulo retangulo = iforma.Retangulo(ladoA: 3, ladoB: 5);
  print("Circulo - Area: ${circulo.area()} - Perimetro: ${circulo.perimetro()}");
  print("Retangulo - Area: ${retangulo.area()} - Perimetro: ${retangulo.perimetro()}");

}
