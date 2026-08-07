void printaImpares(){
  for(int i = 100; i<=200; i++){
    ehImpar(i);
  }
}
void ehImpar(int a) => a % 2 != 0 ? print(a) : null;