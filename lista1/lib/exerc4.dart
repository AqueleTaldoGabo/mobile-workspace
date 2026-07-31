String decrescente(a, b, c){
  int maior = maiorVal(a, maiorVal(b, c));
  int menor = menorVal(a, menorVal(b, c));
  int medio = (a+b+c) - (maior + menor);

  return "é $maior, $medio, $menor";
}
int maiorVal(a, b) => a > b ? a : b;
int menorVal(a, b) => a < b ? a : b;
