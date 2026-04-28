import '../Model/pruebaModel.dart';

class PruebaController {

  String calcularSuma(String input) {
    //validacion vacia
    if (input.isEmpty) {
      return "Error: ingrese un valor";
    }

    //validacion numerica de entero
    final num = int.tryParse(input);
    if (num == null) {
      return "Error: debe ingresar un número entero válido";
    }

    //validacion numero positivo
    if (num <= 0) {
      return "Error: el número debe ser mayor a 0";
    }

    int resultado = PruebaModel.sumSerie(num);
    
    return "La suma es: $resultado";
  }
}