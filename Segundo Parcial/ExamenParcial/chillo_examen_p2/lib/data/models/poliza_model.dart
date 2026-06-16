import '../../domain/entities/poliza.dart';

class PolizaModel extends Poliza {
  PolizaModel({
    super.id,
    required super.cliente,
    required super.tipoSeguro,
    required super.valorAsegurado,
    required super.fechaInicio,
    required super.fechaVencimiento,
  });

  factory PolizaModel.fromJson(Map<String, dynamic> json) {
    return PolizaModel(
      id: json['id'],
      cliente: json['cliente'],
      tipoSeguro: json['tipoSeguro'],
      valorAsegurado: json['valorAsegurado'].toDouble(),
      fechaInicio: json['fechaInicio'],
      fechaVencimiento: json['fechaVencimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente': cliente,
      'tipoSeguro': tipoSeguro,
      'valorAsegurado': valorAsegurado,
      'fechaInicio': fechaInicio,
      'fechaVencimiento': fechaVencimiento,
    };
  }
}