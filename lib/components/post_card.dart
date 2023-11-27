import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/comment.dart';
import 'package:social_if/components/commment_button.dart';
import 'package:social_if/components/like_button.dart';
import 'package:social_if/utils/utils.dart';

class PostCard extends StatefulWidget {

  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final int amountComments;
  // final String time;


  const PostCard({
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.amountComments,
    // required this.time,
    super.key
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {


  final currentUser = FirebaseAuth.instance.currentUser!;
  final postsColletion = FirebaseFirestore.instance.collection('users_posts');
  late int currentAmountComments = 0;
  bool isLiked = true;

  final _commentContent = TextEditingController();

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


  void addComment(String content) async {

    
    final postRef = FirebaseFirestore.instance.collection('users_posts').doc(widget.postId);
    final commentsRef = postRef.collection('comments');

    try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Add the new comment to the 'comments' subcollection
      await commentsRef.add({
        'content': content,
        'author': currentUser.email,
        'time': Timestamp.now(),
      });

      // Increment the 'amountComments' field by 1
      final postSnapshot = await transaction.get(postRef);
      currentAmountComments = await postSnapshot['amountComments'];
      transaction.update(postRef, {'amountComments': currentAmountComments + 1});
    });
  } catch (e) {
    print('Error adding comment and incrementing amountComments: $e');
  }


    // final postRef = FirebaseFirestore.instance.collection('users_posts').doc(widget.postId);
    // final commentsRef = postRef.collection('comments');

    // FirebaseFirestore.instance
    //   .collection('users_posts')
    //   .doc(widget.postId)
    //   .collection('comments')
    //   .add({
    //     'content': content,
    //     'autor': currentUser.email,
    //     'time': Timestamp.now()
    //   });

    // final postSnapshot = await transaction.get(postRef);

  }

  void showCommmentDialog(){
    showDialog(
      context: context, 
      builder: (context) => 
      AlertDialog(
        backgroundColor: Colors.grey[900],
        contentTextStyle: const TextStyle(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        title: const Text('Add Comment'),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: "Write a commnent", hintStyle: TextStyle(color: Colors.grey)),
          controller: _commentContent,

        ),
        actions: [
          TextButton(
              onPressed: () {

                Navigator.pop(context);
                _commentContent.clear();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                addComment(_commentContent.text);
                _commentContent.clear();
              },
              child: const Text('Save',
                  style: TextStyle(color: Colors.white))),
        ],
      )
    );
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
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const  EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.message),
            Text(widget.user, style: TextStyle(color: Colors.grey[500]),),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          
           Row(
            children: [
              
              Container(
                // padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 5),
                child: LikeButton(isLiked: isLiked, onTap: handleLike),
              ),
              Container(
                // padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                margin: const EdgeInsets.only(right: 5),
                child: Text(widget.likes.length.toString()),
              ),    
            ],
          ),
          Row(
            children: [
              
              Container(
                padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.only(right: 5),
                child: CommentButton(onTap: showCommmentDialog),
              ),
              Container(
                // padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                margin: const EdgeInsets.only(right: 5),
                child: Text(widget.amountComments.toString()),
              ),    
            ],
          ),
        ],),


        StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection('users_posts')
          .doc(widget.postId)
          .collection('comments')
          .orderBy('time', descending: true)
          .snapshots(),
          builder: (context, snapshots) {

            if(!snapshots.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshots.data!.docs.map((doc) {
                final commentData = doc.data();

                return Comment(
                    text: commentData['content'], 
                    user: commentData['author'], 
                    time:  formatData(commentData['time'])
                  );
              }).toList()
            );
            
          }
        )
        ],
      ),
    );
  }
}