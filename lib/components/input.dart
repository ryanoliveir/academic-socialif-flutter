import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



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
      cursorColor: Colors.white,
      decoration: InputDecoration(
        
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor('#4CAF50'))
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500])
      ),
    );
  }
}
