import 'package:lista3/pedido.dart' as pedido;

void main(List<String> arguments) {
  pedido.Pedido pedido1 = pedido.Pedido(numeroPedido: "1234");
  pedido1.codigoRastreio = "32456";
  print("Pedido1 - ${pedido1.numeroPedido} e ${pedido1.codigoRastreio}");

}
