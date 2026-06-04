//CONEXION CON LA DB, EN ESTE CASO API
import '../../domain/entities/nasa.dart';
import '../datasources/nasaapi_datasource.dart';

class NasaRepository {
  //INSTANCIAR DATASOURCE
  final NasaApiDatasource nasaApiDatasource;

  NasaRepository(this.nasaApiDatasource);

  Future<List<Nasa>> getApods({int count = 10}) async {
    return nasaApiDatasource.fetchNasa(count: count);
  }
}