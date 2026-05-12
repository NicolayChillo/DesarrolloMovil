import 'package:flutter/material.dart';

import '../../tema/tema_general.dart';
import '../moleculas/formulario_pedido.dart';
import '../../model/pedido_helado_modelo.dart';

class VistaHeladeria extends StatelessWidget {
  const VistaHeladeria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: TemaGeneral.temaClaro,
      child: Scaffold(
        appBar: AppBar(title: Text('Heladería')),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: FormularioPedido(
              onSubmit: (PedidoHeladoModelo pedido) {
                Navigator.of(context).pushNamed(
                  '/notaVentaHelado',
                  arguments: pedido,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
