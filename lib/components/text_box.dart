

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextBox extends StatelessWidget {

  final String text;
  final String sectionName;
  final void Function()? onTap;

  const TextBox({
    required this.text,
    required this.sectionName,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey[500])),
              IconButton(onPressed: onTap, icon: Icon(Icons.settings, color: HexColor('#4CAF50')))
            ]
          ),
          Text(text),
        ],
      ),
    );
  }
}