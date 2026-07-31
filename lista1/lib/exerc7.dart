void tabuada(a){
  for(int i = 0; i<=10; i++){
    print("$i x $a = ${multiplicacao(i, a)}");
  }
}
int multiplicacao(a, b) => a*b;