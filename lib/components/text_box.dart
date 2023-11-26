

import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {

  final String text;
  final String sectionName;


  const TextBox({
    required this.text,
    required this.sectionName,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey[500]),),
            ]
          ),
          Text(text),
        ],
      ),
    );
  }
}