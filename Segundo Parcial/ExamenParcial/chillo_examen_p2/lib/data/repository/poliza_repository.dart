import '../../domain/entities/poliza.dart';

abstract class PolizaRepository {
  Future<List<Poliza>> obtenerPolizas();

  Future<void> registrarPoliza(Poliza poliza);

  Future<void> actualizarPoliza(Poliza poliza);

  Future<void> eliminarPoliza(int id);
}