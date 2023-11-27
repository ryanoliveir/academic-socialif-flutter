import 'package:flutter/material.dart';



class Input extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;

  const Input({
    required this.controller,
    required this.hintText,
    required this.isObscureText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500])
      ),
    );
  }
}
