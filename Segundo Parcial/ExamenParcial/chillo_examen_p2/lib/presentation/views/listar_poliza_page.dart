import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/poliza_viewmodel.dart';
import 'editar_poliza_page.dart';

class ListarPolizasPage extends StatelessWidget {
  const ListarPolizasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PolizaViewModel>(
      builder: (context, viewModel, child) {

        if (viewModel.polizas.isEmpty) {
          return const Center(
            child: Text('No existen pólizas registradas'),
          );
        }

        return ListView.builder(
          itemCount: viewModel.polizas.length,
          itemBuilder: (context, index) {

            final poliza = viewModel.polizas[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: ListTile(

                title: Text(
                  poliza.cliente,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Póliza #${poliza.id ?? 0}'),
                    Text('Tipo: ${poliza.tipoSeguro}'),
                    Text('Valor: \$${poliza.valorAsegurado}'),
                    Text('Inicio: ${poliza.fechaInicio}'),
                    Text('Vence: ${poliza.fechaVencimiento}'),
                  ],
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// EDITAR
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditarPolizaView(
                              poliza: poliza,
                            ),
                          ),
                        );

                        /// NO necesitas recargar nada
                        /// notifyListeners() ya actualiza la UI
                      },
                    ),

                    /// ELIMINAR
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {

                        final confirmar = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Eliminar póliza'),
                              content: const Text(
                                '¿Seguro que deseas eliminar esta póliza?',
                              ),
                              actions: [

                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Cancelar'),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmar == true) {
                          await viewModel.eliminarPoliza(
                            poliza.id ?? 0,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Póliza eliminada correctamente'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}