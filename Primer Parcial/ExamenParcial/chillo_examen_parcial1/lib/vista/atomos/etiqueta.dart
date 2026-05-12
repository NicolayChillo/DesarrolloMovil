import 'package:flutter/material.dart';

class Etiqueta extends StatelessWidget {
  final String text;

  const Etiqueta(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
