import '../entities/nasa.dart';
import '../../data/repository/nasa_repository.dart';

class GetNasaUsecase {
  final NasaRepository repository;

  GetNasaUsecase({required this.repository});

  Future<List<Nasa>> call({int count = 10}){
    return repository.getApods(count: count);
  }

}