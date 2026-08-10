class Pessoa{
  Pessoa({required this.nome, required this.idade});

  void apresentar(){
    print("Ola meu nome é $nome e tenho $idade anos");
  }

  String nome;
  int idade;
}