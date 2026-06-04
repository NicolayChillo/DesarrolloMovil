import 'dart:convert'; //para decodificar json
import 'package:http/http.dart' as http; // para consumir del internet

import '../models/pokemon_model.dart';

class PokeApiDatasource {
  //VARIABLE PARA OBTENER LA API
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  //CREAR UN METODO ASINCRONICO fetch
  //demostrar que trabajare en una tarea asincronica
  //indica que tendra una tarea asincronica
  Future<List<PokemonModel>> fetchPokemons(int limit, int offset) async {
    final url = Uri.parse("$baseUrl?lmit=$limit&offset=$offset");
    final resp = await  http.get(url);

    //CONTROL DE ERRORES
    if(resp.statusCode != 200) {
      throw Exception("Error al presentar los Pokemons");
    }

    //DECODIFICACION
    //jsonDecode de json a objeto
    //jsonEncode de objeto a json
    final data = jsonDecode(resp.body);
    final List results = data["results"];

    //ITERANDO SOBRE CADA ELEMENTO JSON
    return results.map((e) => PokemonModel.fromJson(e)).toList();
  }
}