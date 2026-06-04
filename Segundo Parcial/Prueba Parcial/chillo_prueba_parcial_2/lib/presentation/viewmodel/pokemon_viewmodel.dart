import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecase/get_pokemon_usecase.dart';

class PokemonViewmodel extends ChangeNotifier{
  final GetPokemonUsecase getPokemonUsecase;

  PokemonViewmodel({required this.getPokemonUsecase});

  //LISTAS POKEMON
  List<Pokemon> pokemons = [];
  bool loading = false; //para esperar a que se carguen los datos
  String? errorMessage; //para mostrar un mensaje de error en caso de que no se puedan cargar los datos

  //FUTURE para ocupar metodos asyncronos
  Future<void> loadPolemons() async{
    loading = true; 
    notifyListeners(); //para actualizar la vista

    try{
        pokemons = await getPokemonUsecase(); //llama al usecase para obtener los pokemons
    }catch(e){
      errorMessage = "Error al cargar los pokemons"; //mensaje de error
    }

    loading = false;
    notifyListeners(); //para actualizar la vista

  }


}

