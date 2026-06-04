import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/nasa_viewmodel.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{ 
  @override
  void initState(){

    super.initState();

    Future.microtask(()=> 
      Provider.of<NasaViewmodel>(context, listen: false).loadNasa(count: 10)
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NasaViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("NASA APOD"),
      ),
      body: Builder(
        builder: (context) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(vm.errorMessage!),
            );
          }

          if (vm.apods.isEmpty) {
            return const Center(
              child: Text('No hay imágenes disponibles.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.apods.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (_, index) {
              final apod = vm.apods[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/detalle", arguments: apod);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              apod.url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Flexible(
                          child: Text(
                            apod.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(apod.date),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



