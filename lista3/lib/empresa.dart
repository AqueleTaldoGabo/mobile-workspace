class Empresa {
  Empresa({required this.nome}){
    totalFuncionarios+= 1;
  }
  
  String nome;
  static int totalFuncionarios = 0;

  int get totalFuncionario{
    return totalFuncionarios;
  }
}
