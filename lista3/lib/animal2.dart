class Animal {
  void emitirSom(){
    print("Faz barulho");
  }
}
class Cachorro extends Animal{
  @override
  void emitirSom() {
    print("Auauauauau");
  }
}
class Gato extends Animal{
  @override
  void emitirSom() {
    print("Miau");
  }
}