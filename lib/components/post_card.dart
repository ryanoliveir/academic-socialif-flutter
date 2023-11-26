

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/like_button.dart';

class PostCard extends StatefulWidget {

  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  // final String time;


  const PostCard({
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    // required this.time,
    super.key
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {


  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = true;

  void handleLike(){
    setState(() {
      isLiked = !isLiked;
    });


    DocumentReference postRef = FirebaseFirestore.instance.collection('users_posts').doc(widget.postId);
    if(isLiked) {

      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email])
      });

    } else {

      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
    }


  }

  @override
  void initState(){
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

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
          Column(
            children: [
              
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 12),
                child: LikeButton(isLiked: isLiked, onTap: handleLike),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                margin: const EdgeInsets.only(right: 12),
                child: Text(widget.likes.length.toString()),
              ),    
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.user, style: TextStyle(color: Colors.grey[500]),),
            Text(widget.message)
          ],)
        ],
      ),
    );
  }
}