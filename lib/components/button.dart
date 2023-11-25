import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  VoidCallback onTap;
  final String text;

  Button({
    required this.onTap,
    required this.text,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration:  BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text, style: const TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}