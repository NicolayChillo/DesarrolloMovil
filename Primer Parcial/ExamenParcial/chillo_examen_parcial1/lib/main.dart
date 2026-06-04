import 'package:flutter/material.dart';

import 'tema/export.dart';
import 'vista/paginas/vista_heladeria.dart';
import 'vista/paginas/vista_nota_venta_helado.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heladería',
      theme: TemaGeneral.temaClaro,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const VistaHeladeria(),
        '/heladeria': (context) => const VistaHeladeria(),
        '/notaVentaHelado': (context) => const VistaNotaVentaHelado(),
      },
    );
  }
}
