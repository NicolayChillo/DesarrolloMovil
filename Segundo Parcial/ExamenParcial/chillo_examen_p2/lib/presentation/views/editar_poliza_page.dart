import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/poliza.dart';
import '../viewmodel/poliza_viewmodel.dart';

class EditarPolizaView extends StatefulWidget {

  final Poliza poliza;

  const EditarPolizaView({
    super.key,
    required this.poliza,
  });

  @override
  State<EditarPolizaView> createState() => _EditarPolizaViewState();
}

class _EditarPolizaViewState extends State<EditarPolizaView> {

  late TextEditingController clienteController;
  late TextEditingController montoController;
  late TextEditingController fechaController;
  late TextEditingController fechaVencimientoController;
  String? _tipoSeguroSeleccionado;

  final _formKey = GlobalKey<FormState>();

  static const List<String> _tiposSeguro = [
    'Vehicular',
    'Salud',
    'Vida',
    'Hogar',
    'Viaje',
  ];

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

  @override
  void initState() {
    super.initState();
    
    clienteController =
        TextEditingController(text: widget.poliza.cliente);

    _tipoSeguroSeleccionado = widget.poliza.tipoSeguro;

    montoController =
        TextEditingController(
        text: widget.poliza.valorAsegurado.toString(),
        );

    fechaController =
        TextEditingController(text: widget.poliza.fechaInicio);

    fechaVencimientoController =
      TextEditingController(text: widget.poliza.fechaVencimiento);
  }

  @override
  void dispose() {
    clienteController.dispose();
    montoController.dispose();
    fechaController.dispose();
    fechaVencimientoController.dispose();
    super.dispose();
  }

  Future<void> actualizarPoliza() async {

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Revisa los campos y las fechas ingresadas'),
        ),
      );
      return;
    }

    final viewModel = Provider.of<PolizaViewModel>(context, listen: false);

    await viewModel.actualizarPoliza(
      id: widget.poliza.id ?? 0,
      cliente: clienteController.text,
      tipoSeguro: _tipoSeguroSeleccionado ?? '',
      valorAsegurado: double.parse(montoController.text),
      fechaInicio: fechaController.text,
      fechaVencimiento: fechaVencimientoController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Póliza actualizada correctamente'),
      ),
    );

    Navigator.pop(context,true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Editar Póliza'),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(

            children: [

              TextFormField(
                controller: clienteController,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              FormField<String>(
                validator: (_) {
                  if (_tipoSeguroSeleccionado == null || _tipoSeguroSeleccionado!.isEmpty) {
                    return 'Campo requerido';
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

              const SizedBox(height: 15),

              TextFormField(
                controller: montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor Asegurado',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: fechaController,
                readOnly: true,
                onTap: () => _seleccionarFecha(
                  controller: fechaController,
                ),
                decoration: const InputDecoration(
                  labelText: 'Fecha de Inicio',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : (_parseDate(value) == null ? 'Seleccione una fecha válida' : null),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: fechaVencimientoController,
                readOnly: true,
                onTap: () => _seleccionarFecha(
                  controller: fechaVencimientoController,
                  firstDate: _parseDate(fechaController.text) ?? DateTime(2000),
                ),
                decoration: const InputDecoration(
                  labelText: 'Fecha de Vencimiento',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : (
                      _parseDate(value) == null
                        ? 'Seleccione una fecha válida'
                        : (_parseDate(fechaController.text) != null && _parseDate(value)!.isBefore(_parseDate(fechaController.text)!)
                          ? 'La fecha de vencimiento no puede ser anterior a la de inicio'
                          : null)
                    ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: actualizarPoliza,
                  child: const Text(
                    'Actualizar Póliza',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}