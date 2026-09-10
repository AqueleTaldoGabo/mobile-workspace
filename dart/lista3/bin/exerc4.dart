import 'package:lista3/contaBancaria.dart' as contabancaria;

void main(List<String> arguments) {
  contabancaria.ContaBancaria conta1 = contabancaria.ContaBancaria(nome: "Carlos");
  conta1.saldo = 190;
  print("Nome: ${conta1.nome}, saldo: ${conta1.saldo}");
}
