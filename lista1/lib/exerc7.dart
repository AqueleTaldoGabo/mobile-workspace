void tabuada(int a){
  for(int i = 0; i<=10; i++){
    print("$i x $a = ${multiplicacao(i, a)}");
  }
}
int multiplicacao(int a, int b) => a*b;