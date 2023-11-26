import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/post_card.dart';
import 'package:social_if/components/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersColletion = FirebaseFirestore.instance.collection('users');
  final postsColletion = FirebaseFirestore.instance.collection('users_posts');

  Future<void> editDetails(String field) async {
    String newValue = "";

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              contentTextStyle: const TextStyle(color: Colors.white),
              titleTextStyle: const TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('Edit $field', style: const TextStyle(fontSize: 16)),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter with new $field",
                    hintStyle: const TextStyle(color: Colors.grey)),
                onChanged: (value) => newValue = value,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white))),
              ],
            ));

    if (newValue.trim().isNotEmpty) {
      await usersColletion.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Profile Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Column(children: [
                      const Icon(Icons.person, size: 72),
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text('My Details',
                        style: TextStyle(color: Colors.grey[500])),
                  ),
                  TextBox(
                    text: userData['username'],
                    sectionName: 'Username',
                    onTap: () => editDetails('username'),
                  ),
                  TextBox(
                    text: userData['bio'],
                    sectionName: 'Bio',
                    onTap: () => editDetails('bio'),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text('My Posts',
                        style: TextStyle(color: Colors.grey[500])),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.
                          collection("users_posts")
                          .where('userEmail', isEqualTo: currentUser.email)
                          .snapshots(),
                      builder: (context, postSnapshot) {
                        if (postSnapshot.hasData) {
                          
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: postSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = postSnapshot.data!.docs[index];
                            
                              return PostCard(
                                  message: post['message'],
                                  user: post['userEmail'],
                                  postId: post.id,
                                  likes:
                                  List<String>.from(post['likes'] ?? []));
                            },
                          );
                        } else if (postSnapshot.hasError){
                          return Center(child: Text("Error: ${postSnapshot.error} "),);
                        }
                        return const Center(child: CircularProgressIndicator());
                      }
                    ),
                   const SizedBox(height: 40)
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error} "),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
