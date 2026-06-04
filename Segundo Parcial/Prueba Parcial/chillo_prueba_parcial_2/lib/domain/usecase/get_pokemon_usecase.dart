import '../entities/pokemon.dart';
import '../../data/repository/pokemon._repository.dart';

//DEFINE QUE ACCION VA A REALIZAR LA APP
//RECUPERAR LOS DATOS DE LA API POKEMON
class GetPokemonUsecase {
  //INYECCION DE DEPENDENCI/INSTANCIACION
  final PokemonRepository repository;

  GetPokemonUsecase({required this.repository});

  //FUTURE
  Future<List<Pokemon>> call(){
    return repository.getPokemons(limit:30, offset: 0);
  }

}