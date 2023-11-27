

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DrawerList extends StatelessWidget {
  final IconData icon;
  final String textTitle;
  final Function()? onTap;

  const DrawerList({
    required this.icon,
    required this.textTitle,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(icon, color: HexColor('#4CAF50')),
        onTap: onTap,
        textColor: Colors.white,
        title: Text(textTitle)
      ),
    );
  }
}