import 'package:flutter/material.dart';

import '../../model/pedido_helado_modelo.dart';
import '../atomos/etiqueta.dart';

class ResumenNotaVenta extends StatelessWidget {
  final PedidoHeladoModelo pedido;

  const ResumenNotaVenta({Key? key, required this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Etiqueta('Cliente: ${pedido.nombreCliente}'),
            SizedBox(height: 6),
            Etiqueta('Presentación: ${pedido.presentacion}'),
            SizedBox(height: 6),
            Etiqueta('Número de bolas: ${pedido.numeroBolas}'),
            SizedBox(height: 6),
            Etiqueta('Topping: ${pedido.topping}'),
            Divider(),
            Etiqueta('Subtotal: ${pedido.subtotal.toStringAsFixed(2)}'),
            Etiqueta('IVA: ${pedido.iva.toStringAsFixed(2)}'),
            Etiqueta('Total: ${pedido.total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
