import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tema/export.dart';
import 'presentation/viewmodel/poliza_viewmodel.dart';
import 'presentation/views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PolizaViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TemaGeneral.temaClaro,
        themeMode: ThemeMode.light,
        home: HomeView(),
      ),
    ),
  );
}
