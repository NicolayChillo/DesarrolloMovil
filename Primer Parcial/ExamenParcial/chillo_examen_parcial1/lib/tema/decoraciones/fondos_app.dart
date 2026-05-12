import 'package:flutter/material.dart';
import 'package:tema_personalizado/tema/colores_app.dart';

class FondosApp {

  // FONDO CON GRADIENTE
  static final BoxDecoration gradientePrincipal =
      BoxDecoration(

    gradient: LinearGradient(

      colors: [
        ColoresApp.primario,
        Color(0xFF8B85FF),
      ],

      begin: Alignment.topLeft,

      end: Alignment.bottomRight,
    ),
  );

  // FONDO BLANCO
    static final BoxDecoration fondoBlanco =
      BoxDecoration(
    color: Colors.white,
  );

  // FONDO GRIS
  static final BoxDecoration fondoGris =
      BoxDecoration(
    color: ColoresApp.fondo,
  );
}