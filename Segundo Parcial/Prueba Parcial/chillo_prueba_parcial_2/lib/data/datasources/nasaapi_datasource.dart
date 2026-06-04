import 'dart:convert'; //para decodificar json
import 'package:http/http.dart' as http; // para consumir del internet

import '../constants/api_constants.dart';
import '../models/nasa_model.dart';

class NasaApiDatasource {
  Future<List<NasaModel>> fetchNasa({int count = 10}) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/planetary/apod?api_key=${ApiConstants.nasaApiKey}&count=$count",
    );
    final resp = await  http.get(url);

    if(resp.statusCode != 200) {
      throw Exception("Error al obtener datos de NASA");
    }

    final data = jsonDecode(resp.body);
    final List results = data is List ? data : [data];

    return results
        .where((e) => e is Map<String, dynamic> && e["media_type"] == "image")
        .map((e) => NasaModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}