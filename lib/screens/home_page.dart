import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/input.dart';
import 'package:social_if/components/post_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final currentUser = FirebaseAuth.instance.currentUser!;
  final _textPost = TextEditingController();


  void makePost(){
    if(_textPost.text.isNotEmpty){

        FirebaseFirestore.instance.collection("users_posts").add({
          'userEmail': currentUser.email,
          'message': _textPost.text,
          'timestamp': Timestamp.now(),
          'likes': []
        });

    }


    setState(() {
    _textPost.clear();
    });

  }

  
 

  void singOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(
          'Social IF',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: singOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                .collection("users_posts")
                .orderBy("timestamp", descending: false)
                .snapshots(),
              
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return PostCard(
                          message: post['message'], 
                          user: post['userEmail'],
                          postId: post.id,
                          likes: List<String>.from(post['likes'] ?? [])
                        );
                    },);
                  } else if (snapshot.hasError){
                    return Center(child: Text("Error: ${snapshot.error} "),);
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Input(
                      controller: _textPost,
                      isObscureText: false,
                      hintText: 'Make a post !!',
                    ),
                  ),
                  IconButton(
                    onPressed: makePost, 
                    icon: const Icon(Icons.send)
                  )
                ],
              ),
            ),
            Text("Loggin in as:${currentUser.email!}")
      
        ]),
      ),
    );
  }
}
