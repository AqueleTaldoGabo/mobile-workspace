import 'package:lista3/produto.dart' as produto;

void main(List<String> arguments) {
  produto.Produto produto1 = produto.Produto(nome: "Salgadinho sem Promoção", valor: 10);
  produto.Produto produto2 = produto.Produto.promocional(nome: "Salgadinho com Promoção", valor: 10);

  print("Produto 1: ${produto1.nome} - ${produto1.valor} ");
  print("Produto 2: ${produto2.nome} - ${produto2.valor} ");

}
