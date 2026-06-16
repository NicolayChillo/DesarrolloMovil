import 'package:flutter/material.dart';
import '../../domain/entities/poliza.dart';

class PolizaViewModel extends ChangeNotifier {

  final List<Poliza> _polizas = [];
  int _nextId = 1;

  PolizaViewModel();

  List<Poliza> get polizas => List.unmodifiable(_polizas);

  Future<void> registrarPoliza({
    required String cliente,
    required String tipoSeguro,
    required double valorAsegurado,
    required String fechaInicio,
    required String fechaVencimiento,
  }) async {

    final poliza = Poliza(
      id: _nextId++,
      cliente: cliente,
      tipoSeguro: tipoSeguro,
      valorAsegurado: valorAsegurado,
      fechaInicio: fechaInicio,
      fechaVencimiento: fechaVencimiento,
    );

    _polizas.add(poliza);
    notifyListeners();
  }

  Future<void> actualizarPoliza({
    required int id,
    required String cliente,
    required String tipoSeguro,
    required double valorAsegurado,
    required String fechaInicio,
    required String fechaVencimiento,
  }) async {

    final poliza = Poliza(
      id: id,
      cliente: cliente,
      tipoSeguro: tipoSeguro,
      valorAsegurado: valorAsegurado,
      fechaInicio: fechaInicio,
      fechaVencimiento: fechaVencimiento,
    );

    final index = _polizas.indexWhere((element) => element.id == id);
    if (index != -1) {
      _polizas[index] = poliza;
    }

    notifyListeners();
  }

  Future<void> eliminarPoliza(int id) async {
  _polizas.removeWhere((element) => element.id == id);
  notifyListeners();
}
}