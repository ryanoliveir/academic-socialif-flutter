

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LikeButton extends StatelessWidget {

  final bool isLiked;
  final void Function()? onTap;

  const LikeButton({
    required this.isLiked,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Icon(
        isLiked? Icons.favorite: Icons.favorite_outline,
        color: isLiked? HexColor('#4CAF50'): Colors.grey
        ),
    );
  }
}