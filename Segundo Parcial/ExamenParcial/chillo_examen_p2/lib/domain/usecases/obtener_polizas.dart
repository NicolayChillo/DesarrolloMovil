import '../../data/repository/poliza_repository.dart';
import '../entities/poliza.dart';

class ObtenerPolizas {
  final PolizaRepository repository;

  ObtenerPolizas(this.repository);

  Future<List<Poliza>> call() {
    return repository.obtenerPolizas();
  }
}