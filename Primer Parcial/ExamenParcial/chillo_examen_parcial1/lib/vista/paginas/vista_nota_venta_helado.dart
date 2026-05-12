import 'package:flutter/material.dart';

import '../../tema/tema_general.dart';
import '../../model/pedido_helado_modelo.dart';
import '../moleculas/resumen_nota_venta.dart';

class VistaNotaVentaHelado extends StatelessWidget {
  final PedidoHeladoModelo? pedido;

  const VistaNotaVentaHelado({Key? key, this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PedidoHeladoModelo? pedidoActual =
        pedido ?? ModalRoute.of(context)?.settings.arguments as PedidoHeladoModelo?;

    return Theme(
      data: TemaGeneral.temaClaro,
      child: Scaffold(
        appBar: AppBar(title: Text('Nota de Venta')),
        body: pedidoActual == null
            ? const Center(
                child: Text('No se encontro la información del pedido'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ResumenNotaVenta(pedido: pedidoActual),
                ],
              ),
      ),
    );
  }
}
