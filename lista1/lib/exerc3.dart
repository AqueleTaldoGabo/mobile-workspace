double somaComplicada(int a, int b, double c){
  int soma = somaLevementeComplicada(a, b);
  return soma + c;
}
int somaLevementeComplicada(int a, int b) => a == b ? a + b : a * b;