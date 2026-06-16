import 'package:flutter/material.dart';
import 'perfil_page.dart';
import 'listar_poliza_page.dart';
import 'registrar_poliza_page.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int index = 0;

  final paginas = [
    PerfilPage(),
    RegistrarPolizaPage(),
    ListarPolizasPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: paginas[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,

        onTap: (value) {
          setState(() {
            index = value;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Registrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pólizas',
          ),
        ],
      ),
    );
  }
}