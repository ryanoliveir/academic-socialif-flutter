import 'package:flutter/material.dart';
import 'package:social_if/components/button.dart';
import 'package:social_if/components/input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                const SizedBox(height: 50),
                //Logo
                const Icon(Icons.lock, size: 100),
                // Message
        
                const SizedBox(height: 50),
                const Text('Welcome Student'),
        
                const SizedBox(height: 25),
                //Logo
        
        
                Input(
                  controller: _emailInputController, 
                  hintText: "Your e-mail", 
                  isObscureText: false
                ),

                const SizedBox(height: 10),
                
                Input(
                  controller: _passwordInputController, 
                  hintText: "Your password", 
                  isObscureText: true
                ),

                const SizedBox(height: 10),
                
                Button(onTap: (){}, text: 'Sign in'),

                 const SizedBox(height: 10),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Doesn\'t have account ?'),
                  Text('Register now', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))

                ],)
                
              ],
            ),
          ),
        ),
      ) 
      // Logo

      // Messsage 

      // Email field

      // Password field


      // Sign in button


      // Register button
    );
  }
}