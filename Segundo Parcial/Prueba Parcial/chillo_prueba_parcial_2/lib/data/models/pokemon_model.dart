import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {

  PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl
  });

  //FACTORY: INSTANCIAR LOS OBJETOS CUNATAS VECES QUIERA
  factory PokemonModel.fromJson(Map<String, dynamic> json){
    final url = json["url"]; //OBTIENE LA URL
    final parts = url.split("/"); // PARA IR SEPARANDO
    final id = int.parse(parts [parts.length -2]); //CONVERTIR PENULTIMO A ENTERO

    //
    final imgUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
    return PokemonModel(
        id: id,
        name: json["name"],
        imageUrl: imgUrl);
  }
}