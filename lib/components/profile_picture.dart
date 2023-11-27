import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePicture extends StatelessWidget {

  final void Function()? onTap;
  final String imageUrl;

  const ProfilePicture({
    required this.imageUrl,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: HexColor('#4CAF50')),
            shape: BoxShape.circle,
            image:  DecorationImage(
              fit: BoxFit.fitHeight,
              image: NetworkImage(imageUrl)
            )
          ),
          
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(width: 2, color: HexColor('#4CAF50')),
              shape: BoxShape.circle,
            ),
            child: IconButton(icon: const Icon(Icons.edit, size: 17,), onPressed: onTap),
          )
        )
      ]
        
    );
  }
}