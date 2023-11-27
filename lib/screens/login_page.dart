import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_if/components/button.dart';
import 'package:social_if/components/input.dart';

class Login extends StatefulWidget {
   final Function()? onTap;

  const Login({
    required this.onTap,
    super.key
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

 

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();


  void signIn () async {


    BuildContext? localContext = context;

    showDialog(context: context, 
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  
    );


    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailInputController.text, 
      password: _passwordInputController.text
      );

      if(localContext.mounted) Navigator.pop(context);

    } on FirebaseAuthException {
       if(localContext.mounted) Navigator.pop(context);
      loginError('Check your email and password');
    }
   
  }


  void loginError (String message){
    showDialog(context: context, 
    builder: (context) => AlertDialog(
      title: Text(message),
    )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    
                       
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
                  
                  Button(onTap: signIn, text: 'Sign in'),
            
                   const SizedBox(height: 10),
            
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Doesn\'t have account ?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(' Register now', style: TextStyle(fontWeight: FontWeight.bold, color: HexColor('#4CAF50'))),
                    ),
                  
                  ],)
                  
                ],
              ),
            ),
          ),
        ),
      ) 
    );
  }
}