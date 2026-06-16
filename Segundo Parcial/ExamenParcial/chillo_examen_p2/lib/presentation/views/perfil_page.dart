import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text(
              'Bienvenido',
            ),

            const SizedBox(height: 15),

            const Text(
              'Sistema de Gestión de Pólizas de Seguro',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              'Desde esta aplicación podrá registrar, consultar, actualizar y eliminar pólizas de seguro.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}