import 'package:flutter/material.dart';
import '../../domain/entities/nasa.dart';
import '../../domain/usecase/get_nasa_usecase.dart';

class NasaViewmodel extends ChangeNotifier{
  final GetNasaUsecase getNasaUsecase;

  NasaViewmodel({required this.getNasaUsecase});

  List<Nasa> apods = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadNasa({int count = 10}) async{
    loading = true;
    errorMessage = null;
    notifyListeners();

    try{
        apods = await getNasaUsecase(count: count);
    }catch(e){
      errorMessage = "Error al cargar los datos de NASA";
    }

    loading = false;
    notifyListeners();

  }


}

