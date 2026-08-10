import 'package:lista3/pessoa.dart' as pessoa;

void main(List<String> arguments) {
  pessoa.Pessoa pessoa1 = pessoa.Pessoa(nome: "Carlos", idade: 10);
  print(pessoa1.nome);
  print(pessoa1.idade);

}
