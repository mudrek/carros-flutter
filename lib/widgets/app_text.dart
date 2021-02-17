import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FormFieldValidator<String> validator;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    @required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: password,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 25,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
