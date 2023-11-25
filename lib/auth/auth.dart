import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/auth/auth_switch.dart';
import 'package:social_if/screens/home_page.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            return const Home();
          } else {
            return const AuthSwitch();
          }
        },

      ) 
    );
  }
}
