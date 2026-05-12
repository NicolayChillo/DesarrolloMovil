import '../model/pedido_helado_modelo.dart';

class HeladoControlador {

  String? ultimoError;

  //precios por presentación
  static const Map<String, double> preciosPresentacion = {
    'Cono': 1.50,
    'Vaso': 3.00,
    'Tarrina': 5.00
  };

  //precios de toppings
  static const Map<String, double> preciosToppings = {
    'Ninguno': 0,
    'Chocolate': 0.50,
    'Chispas': 0.75
  };

  //iva del 15%
  static const double IVA = 0.15; 

  //validacion campos vacíos
  String? validarCamposVacios(String nombreCliente, String presentacion, String topping) {
    if (nombreCliente.trim().isEmpty) {
      return 'El nombre del cliente no puede estar vacío';
    }
    if (presentacion.trim().isEmpty) {
      return 'Debe seleccionar una presentación';
    }
    if (topping.trim().isEmpty) {
      return 'Debe seleccionar un topping';
    }
    return null;
  }

  //validacion numero de bolas: debe ser numero entero y mayor a cero
  String? validarNumeroBolas(String numeroBolasTexto) {
    final int? numeroBolas = int.tryParse(numeroBolasTexto.trim());

    if (numeroBolas == null) {
      return 'El número de bolas debe ser un número válido y mayor a 0';
    }
    if (numeroBolas <= 0) {
      return 'El número de bolas debe ser mayor a cero';
    }
    return null;
  }

  //asignar precio segun presentación
  double obtenerPrecioPresentacion(String presentacion) {
    return preciosPresentacion[presentacion] ?? 0;
  }

  //asignar precio segun topping
  double obtenerPrecioTopping(String topping) {
    return preciosToppings[topping] ?? 0;
  }

  //caalcula el subtotal
  double calcularSubtotal( String presentacion, int numeroBolas, String topping) {
    double precioPresentacion = obtenerPrecioPresentacion(presentacion);
    double precioTopping = obtenerPrecioTopping(topping);

    return (precioPresentacion * numeroBolas) + precioTopping;
  }

  //calculo del iva
  double calcularIVA(double subtotal) {
    return subtotal * IVA;
  }

  //calcula total
  double calcularTotal(double subtotal) {
    return subtotal + calcularIVA(subtotal);
  }

  //procesar pedido completo
  PedidoHeladoModelo? procesarPedido(
    String nombreCliente,
    String presentacion,
    String numeroBolasTexto,
    String topping,
  ) {

    ultimoError = null;

    //validar campos vacios
    String? errorCampos =
        validarCamposVacios(nombreCliente, presentacion, topping);
    if (errorCampos != null) {
      ultimoError = errorCampos;
      return null;
    }

    //validar numero de bolas
    String? errorBolas = validarNumeroBolas(numeroBolasTexto);
    if (errorBolas != null) {
      ultimoError = errorBolas;
      return null;
    }

    final int numeroBolas = int.parse(numeroBolasTexto.trim());

    //calcular subtotal
    double subtotal = calcularSubtotal(presentacion, numeroBolas, topping);

    //calcular iva
    double iva = calcularIVA(subtotal);

    //calcular total
    double total = calcularTotal(subtotal);

    //retornar el modelo del pedido
    return PedidoHeladoModelo(
      nombreCliente: nombreCliente,
      presentacion: presentacion,
      numeroBolas: numeroBolas,
      topping: topping,
      subtotal: subtotal,
      iva: iva,
      total: total,
    );
  }

  //obtener lista de presentaciones disponibles
  List<String> obtenerPresentaciones() {
    return preciosPresentacion.keys.toList();
  }

  //obtener lista de toppings disponibles
  List<String> obtenerToppings() {
    return preciosToppings.keys.toList();
  }
}