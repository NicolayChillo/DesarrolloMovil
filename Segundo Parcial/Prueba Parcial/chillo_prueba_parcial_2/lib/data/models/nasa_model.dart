import '../../domain/entities/nasa.dart';

class NasaModel extends Nasa {
  NasaModel({
    required super.title,
    required super.explanation,
    required super.url,
    required super.date,
  });

  factory NasaModel.fromJson(Map<String, dynamic> json) {
    return NasaModel(
      title: (json["title"] ?? "Sin título") as String,
      explanation: (json["explanation"] ?? "") as String,
      url: (json["url"] ?? "") as String,
      date: (json["date"] ?? "") as String,
    );
  }
}