import 'package:flutter/material.dart';

class TextoInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const TextoInput({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      validator: validator,
    );
  }
}
