enum Pessoa{
  carlos("Carlos", 17),
  gabriel("Gabriel", 18),
  luis("Luis", 20),
  tiago("Tiago", 27),
  christian("Christian", 14);

  final String nome;
  final int idade;

  const Pessoa(this.nome, this.idade);
}

void printarPessoas(List<Pessoa> pessoas) => print(pessoas.where((i) => i.idade >= 18).map((i) => i.nome));