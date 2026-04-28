import 'package:flutter/material.dart';
import '../Controller/pruebaController.dart';

//Atomos
class LabelText extends StatelessWidget {
  final String text;

  LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;

  NumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ingrese un numero: (ejm:10)',
      ),
    );
  }
}

//Boton
class Button extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;


  Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
    );
  }
}

//Etiqueta de resultado96
class ResultLabel extends StatelessWidget{
  final String text;

  ResultLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20),
    );
  }
}

//Molecula
class numInput extends StatelessWidget{
  final TextEditingController controller;

  numInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText('Número: '),
        SizedBox(height: 10,),
        NumberField(controller: controller,),
      ],
    );
  }
}

//Organisto
//declarar el estado
class PruebaCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PruebaCardState();
}

//creo el estado
class PruebaCardState extends State<PruebaCard>{
  final TextEditingController controllerNumber = TextEditingController();

  //instanciar
  final PruebaController pruebaController = PruebaController();

  String resultado = '';

  //Metodo para traer a la vista
  void verificar(){
    setState(() {
      resultado = pruebaController.calcularSuma(controllerNumber.text);
    });
}
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            numInput(controller: controllerNumber,),
            SizedBox(height: 20,),
            Button(onPressed: verificar, text: 'Verificar',),
            SizedBox(height: 20,),
            Text(resultado),
          ],
        ),
      ),

    );
  }
}


//Pagina
class PruebaPagina extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Parcial 1'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: PruebaCard(),
      ),
    );
  }
}