import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/poliza_viewmodel.dart';

class RegistrarPolizaPage extends StatefulWidget {
  const RegistrarPolizaPage({super.key});

  @override
  State<RegistrarPolizaPage> createState() => _RegistrarPolizaViewState();
}

class _RegistrarPolizaViewState extends State<RegistrarPolizaPage> {
  final _clienteController = TextEditingController();
  final _montoController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaVencimientoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static const List<String> _tiposSeguro = [
    'Vehicular',
    'Salud',
    'Vida',
    'Hogar',
    'Viaje',
  ];

  String? _tipoSeguroSeleccionado;

  DateTime? _parseDate(String value) {
    return DateTime.tryParse(value);
  }

  Future<void> _seleccionarFecha({
    required TextEditingController controller,
    DateTime? firstDate,
  }) async {
    final initialDate = _parseDate(controller.text) ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      controller.text = pickedDate.toIso8601String().split('T').first;
    });
  }

  bool _validarFormulario() {
    if (_clienteController.text.trim().isEmpty) return false;
    if (_tipoSeguroSeleccionado == null || _tipoSeguroSeleccionado!.isEmpty) return false;
    if (_montoController.text.trim().isEmpty) return false;
    if (_fechaInicioController.text.trim().isEmpty) return false;
    if (_fechaVencimientoController.text.trim().isEmpty) return false;

    final fechaInicio = _parseDate(_fechaInicioController.text);
    final fechaVencimiento = _parseDate(_fechaVencimientoController.text);

    if (fechaInicio == null || fechaVencimiento == null) return false;
    if (fechaVencimiento.isBefore(fechaInicio)) return false;

    return true;
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _montoController.dispose();
    _fechaInicioController.dispose();
    _fechaVencimientoController.dispose();
    super.dispose();
  }

  Future<void> _registrarPoliza() async {
    if (!_validarFormulario()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Revisa los campos y las fechas ingresadas'),
        ),
      );
      return;
    }

    final viewModel =
    Provider.of<PolizaViewModel>(context, listen: false);

    await viewModel.registrarPoliza(
      cliente: _clienteController.text,
      tipoSeguro: _tipoSeguroSeleccionado ?? '',
      valorAsegurado: double.parse(_montoController.text),
      fechaInicio: _fechaInicioController.text,
      fechaVencimiento: _fechaVencimientoController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Póliza registrada correctamente'),
      ),
    );

    _clienteController.clear();
    _montoController.clear();
    _fechaInicioController.clear();
    _fechaVencimientoController.clear();

    _formKey.currentState?.reset();

    setState(() {
      _tipoSeguroSeleccionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Póliza'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre del cliente';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              FormField<String>(
                validator: (_) {
                  if (_tipoSeguroSeleccionado == null || _tipoSeguroSeleccionado!.isEmpty) {
                    return 'Seleccione el tipo de seguro';
                  }
                  return null;
                },
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tipo de Seguro',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      ..._tiposSeguro.map((tipo) {
                        return RadioListTile<String>(
                          title: Text(tipo),
                          value: tipo,
                          groupValue: _tipoSeguroSeleccionado,
                          onChanged: (value) {
                            setState(() {
                              _tipoSeguroSeleccionado = value;
                            });
                            state.didChange(value);
                          },
                        );
                      }),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor Asegurado',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el valor asegurado';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _fechaInicioController,
                readOnly: true,
                onTap: () => _seleccionarFecha(
                  controller: _fechaInicioController,
                ),
                decoration: const InputDecoration(
                  labelText: 'Fecha de Inicio',
                  hintText: '2026-06-16',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la fecha';
                  }
                  if (_parseDate(value) == null) {
                    return 'Seleccione una fecha válida';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _fechaVencimientoController,
                readOnly: true,
                onTap: () => _seleccionarFecha(
                  controller: _fechaVencimientoController,
                  firstDate: _parseDate(_fechaInicioController.text) ?? DateTime(2000),
                ),
                decoration: const InputDecoration(
                  labelText: 'Fecha de Vencimiento',
                  hintText: '2026-12-16',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la fecha de vencimiento';
                  }
                  final fechaInicio = _parseDate(_fechaInicioController.text);
                  final fechaVencimiento = _parseDate(value);
                  if (fechaInicio != null && fechaVencimiento != null && fechaVencimiento.isBefore(fechaInicio)) {
                    return 'La fecha de vencimiento no puede ser anterior a la de inicio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registrarPoliza,
                  child: const Text('Registrar Póliza'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}