int somaTodosMods(){
  int total = 0;
  for(int i = 1; i<=500; i++){
    total += i % 3 == 0 ? i : 0;
  }
  return total;
}