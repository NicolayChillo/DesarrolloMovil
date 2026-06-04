import 'package:flutter/material.dart';
import '../../domain/entities/nasa.dart';
import '../../tema/export.dart';


class DetallePage extends StatelessWidget{
  //crear el super constructor
  DetallePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final Nasa apod = ModalRoute.of(context)!.settings.arguments as Nasa;

    return Scaffold(
      appBar: AppBar(
        title: Text(apod.title),
      ),
      body: Container(
        decoration: FondosApp.gradientePrincipal,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(apod.url, width: 300),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        apod.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        apod.date,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        apod.explanation,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}