String decrescente(int a, int b, int c){
  int maior = maiorVal(a, maiorVal(b, c));
  int menor = menorVal(a, menorVal(b, c));
  int medio = (a+b+c) - (maior + menor);

  return "é $maior, $medio, $menor";
}
int maiorVal(int a, int b) => a > b ? a : b;
int menorVal(int a, int b) => a < b ? a : b;
