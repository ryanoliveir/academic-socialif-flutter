

import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {

  final String message;
  final String user;
  // final String time;


  const PostCard({
    required this.message,
    required this.user,
    // required this.time,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const  EdgeInsets.all(25),
      child: Row(
        
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 12),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(user, style: TextStyle(color: Colors.grey[500]),),
            Text(message)
          ],)
        ],
      ),
    );
  }
}