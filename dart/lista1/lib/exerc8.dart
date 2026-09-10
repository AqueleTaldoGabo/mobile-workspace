void fatorial(int a){
  print("$a!");
  int fatorado = 1;
  while(a != 0){
    print("$a x");
    fatorado*=a;
    a--;
  }
  print("O resultado é $fatorado");
}
