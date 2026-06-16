class Poliza {
  final int? id;
  final String cliente;
  final String tipoSeguro;
  final double valorAsegurado;
  final String fechaInicio;
  final String fechaVencimiento;

  Poliza({
    this.id,
    required this.cliente,
    required this.tipoSeguro,
    required this.valorAsegurado,
    required this.fechaInicio,
    required this.fechaVencimiento,
  });
}