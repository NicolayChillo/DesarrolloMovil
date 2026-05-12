import 'package:flutter/material.dart';

import '../../controlador/helado_controlador.dart';
import '../../model/pedido_helado_modelo.dart';
import '../atomos/texto_input.dart';
import '../atomos/selector_simple.dart';
import '../atomos/boton_principal.dart';

class FormularioPedido extends StatefulWidget {
  final void Function(PedidoHeladoModelo) onSubmit;

  const FormularioPedido({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<FormularioPedido> createState() => _FormularioPedidoState();
}

class _FormularioPedidoState extends State<FormularioPedido> {
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _bolasCtrl = TextEditingController();
  String? _presentacion;
  String? _topping;

  final HeladoControlador _controlador = HeladoControlador();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextoInput(
            controller: _nombreCtrl,
            label: 'Nombre del cliente',
          ),
          SizedBox(height: 12),
          TextoInput(
            controller: _bolasCtrl,
            label: 'Número de bolas',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          SelectorSimple(
            items: _controlador.obtenerPresentaciones(),
            label: 'Presentación',
            value: _presentacion,
            onChanged: (v) => setState(() => _presentacion = v),
          ),
          SizedBox(height: 12),
          SelectorSimple(
            items: _controlador.obtenerToppings(),
            label: 'Topping',
            value: _topping,
            onChanged: (v) => setState(() => _topping = v),
          ),
          SizedBox(height: 16),
          BotonPrincipal(
            label: 'Generar nota de venta',
            onPressed: () {
              final nombre = _nombreCtrl.text.trim();
              final bolas = _bolasCtrl.text.trim();
              final presentacion = _presentacion ?? '';
              final topping = _topping ?? '';

              final pedido = _controlador.procesarPedido(nombre, presentacion, bolas, topping);
              if (pedido == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_controlador.ultimoError ?? 'Error al procesar pedido')),
                );
                return;
              }

              widget.onSubmit(pedido);
            },
          )
        ],
      ),
    );
  }
}
