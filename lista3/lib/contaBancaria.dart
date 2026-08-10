// ignore_for_file: unnecessary_this

class ContaBancaria {
  ContaBancaria({required this.nome});
  
  String nome;
  double? _saldo;

  double? get saldo{
    return this._saldo;
  }

  set saldo(double? saldo){
    this._saldo = saldo;
  }
}