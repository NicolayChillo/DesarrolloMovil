import 'package:flutter/material.dart';

import '../views/detalle_page.dart';
import '../views/home_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => HomePage(),
      '/detalle': (context) => DetallePage(),
    };
  }
}
