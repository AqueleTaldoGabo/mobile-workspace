class Produto {
  Produto({required this.nome, required this.valor});
  Produto.promocional({required this.nome, required this.valor}){
    valor = valor * 0.9;
  }

  double valor;
  String nome;
}