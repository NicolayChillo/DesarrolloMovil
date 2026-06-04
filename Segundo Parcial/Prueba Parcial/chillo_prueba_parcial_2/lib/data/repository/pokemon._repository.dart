//CONEXION CON LA DB, EN ESTE CASO API
import '../../domain/entities/pokemon.dart';
import '../datasources/pokeapi_datasource.dart';

class PokemonRepository {
  //INSTANCIAR DATASOURCE
  final PokeApiDatasource pokeApiDatasource;

  PokemonRepository(this.pokeApiDatasource);

  Future<List<Pokemon>> getPokemons({int limit = 30, int offset = 0}) async {
    return pokeApiDatasource.fetchPokemons(limit, offset);
  }
}