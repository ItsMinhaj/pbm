import 'package:flutter/material.dart';
import 'package:pbm/utils/static.dart';

class TextInputField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool? obscure;
  const TextInputField({
    Key? key,
    this.label,
    this.controller,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: obscure!,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2)),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
