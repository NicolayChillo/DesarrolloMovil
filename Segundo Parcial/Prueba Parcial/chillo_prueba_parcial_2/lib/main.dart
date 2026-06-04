import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/pokeapi_datasource.dart';
import 'data/repository/pokemon._repository.dart';
import 'domain/usecase/get_pokemon_usecase.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodel/pokemon_viewmodel.dart';

import 'tema/export.dart';

void main() {
  //inyeccion de dependencias
  final datasource = PokeApiDatasource();
  final repository = PokemonRepository(datasource);
  final usecase = GetPokemonUsecase(repository: repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  //inyeccion de dependencias a nivel de la app
  final GetPokemonUsecase usecase;


  const MyApp({super.key, required this.usecase});
  
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonViewmodel(getPokemonUsecase: usecase),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: TemaGeneral.temaClaro,
        initialRoute: "/",
        routes: AppRoutes.getRoutes(),
      ),
    );

  }
}

