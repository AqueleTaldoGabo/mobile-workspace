abstract class Iforma {
  double area();
  double perimetro();
}
class Circulo extends Iforma{
  Circulo({required this.raio});
  double raio;
  double pi = 3.14;
  @override
  double area(){
    return pi * (raio * raio);
  }
  @override
  double perimetro() {
    return 2 * pi * raio; 
  }
}
class Retangulo extends Iforma{
  Retangulo({required this.ladoA, required this.ladoB});
  double ladoA;
  double ladoB;
  @override
  double area() {
    return ladoA * ladoB;
  }
  @override
  double perimetro(){
    return ladoA*2 + ladoB*2;
  }
}