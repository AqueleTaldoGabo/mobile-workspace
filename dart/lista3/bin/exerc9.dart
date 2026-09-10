import 'package:lista3/animal2.dart' as animal;

void main(List<String> arguments) {
  List<animal.Animal> animais = [];
  animais.add(animal.Cachorro());
  animais.add(animal.Gato());
  animais.add(animal.Gato());
  animais.add(animal.Cachorro());
  animais.forEach((animalFor) {animalFor.emitirSom();});
}
