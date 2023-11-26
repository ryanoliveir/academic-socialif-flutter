import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

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
      body: ListView(
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
            child: Text('My Details', style: TextStyle(color: Colors.grey[500])),
          ),
          const TextBox(text: 'ryann', sectionName: 'Username'),
          const TextBox(text: 'I\'m a programmer', sectionName: 'Bio'),
        ],
      ),
    );
  }
}
