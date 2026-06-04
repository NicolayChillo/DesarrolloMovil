import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/nasaapi_datasource.dart';
import 'data/repository/nasa_repository.dart';
import 'domain/usecase/get_nasa_usecase.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodel/nasa_viewmodel.dart';

import 'tema/export.dart';

void main() {
  final datasource = NasaApiDatasource();
  final repository = NasaRepository(datasource);
  final usecase = GetNasaUsecase(repository: repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetNasaUsecase usecase;


  const MyApp({super.key, required this.usecase});
  
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NasaViewmodel(getNasaUsecase: usecase),
        ),
      ],
      child: MaterialApp(
        title: 'NASA APOD',
        debugShowCheckedModeBanner: false,
        theme: TemaGeneral.temaClaro,
        initialRoute: "/",
        routes: AppRoutes.getRoutes(),
      ),
    );

  }
}

