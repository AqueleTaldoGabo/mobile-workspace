enum Pessoa{
  Carlos("Carlos", 17),
  Gabriel("Gabriel", 18),
  Luis("Luis", 20),
  Tiago("Tiago", 27),
  Christian("Christian", 14);

  final String nome;
  final int idade;

  const Pessoa(this.nome, this.idade);
}

void printarPessoas(List<Pessoa> pessoas) => print(pessoas.where((i) => i.idade >= 18).map((i) => i.nome));