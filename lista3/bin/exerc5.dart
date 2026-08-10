import 'package:lista3/empresa.dart' as empresa;

void main(List<String> arguments) {
  empresa.Empresa empresa1 = empresa.Empresa(nome: "Emprestimos");
  print("Empresa1 - ${empresa1.nome}, ${empresa1.totalFuncionario}");
  empresa.Empresa empresa2 = empresa.Empresa(nome: "Comida");
  print("Empresa2 - ${empresa2.nome}, ${empresa2.totalFuncionario}");

}
