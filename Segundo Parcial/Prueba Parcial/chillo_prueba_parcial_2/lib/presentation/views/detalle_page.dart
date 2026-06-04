import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../tema/export.dart';


class DetallePage extends StatelessWidget{
  //crear el super constructor
  DetallePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    //obtencion del pokemon pasado como argumento
    final Pokemon p = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.name.toUpperCase()), //nombre del pokemon en mayusculas
      ),
      body: Container(
        decoration: FondosApp.gradientePrincipal,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(p.imageUrl, width: 300), //imagen del pokemon
                  const SizedBox(height: 20), //espacio entre la imagen y el texto
                  Text(
                    p.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10), //espacio entre el nombre y el id
                  Text(
                    "Id: ${p.id}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ), //id del pokemon
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}