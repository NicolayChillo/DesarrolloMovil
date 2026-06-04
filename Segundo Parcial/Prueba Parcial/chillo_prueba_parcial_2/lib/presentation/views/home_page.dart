import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/pokemon_viewmodel.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{ 
  //INICIALIZANDO EL VIEWMODEL
  @override
  void initState(){

    super.initState();

    //para cargar los pokemons al iniciar la app
    Future.microtask(()=> 
      Provider.of<PokemonViewmodel>(context, listen: false).loadPolemons()
    );
  }

  @override
  Widget build(BuildContext context) {
    //obtencion de los pokemons desde el viewmodel
    final vm = Provider.of<PokemonViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: ListView.builder(
        itemCount: vm.pokemons.length, //cantidad de pokemons obtenidos
        itemBuilder: (_, index) { //construccion de cada item de la lista
          final p = vm.pokemons[index]; //obtencion de cada pokemon
          return Card(
            child: InkWell(
              onTap: () {
                //navegacion a la pagina de detalle del pokemon, pasando el pokemon como argumento
                Navigator.pushNamed(context, "/detalle", arguments: p);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        p.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text("Id: ${p.id}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



