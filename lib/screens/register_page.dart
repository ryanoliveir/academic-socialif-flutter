import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_if/components/button.dart';
import 'package:social_if/components/input.dart';



class Register extends StatefulWidget {

   final Function()? onTap;

  const Register({
    required this.onTap,
    super.key
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _confirmPasswordInputController = TextEditingController();


  void signUp () async {


    // BuildContext? localContext = context;

    showDialog(context: context, 
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  
    );


    if(_passwordInputController.text !=_confirmPasswordInputController.text){
      Navigator.pop(context);
      registerError("Passwors don't match");
      return;
    }


    try {

      UserCredential userCredential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailInputController.text, 
      password: _passwordInputController.text
      );



      // user colletion
      FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.email)
        .set({
          'username': _emailInputController.text.split('@')[0],
          'bio': 'Empty bio...'
        });


      if(context.mounted) Navigator.pop(context);

    } on FirebaseAuthException catch(e){
       if(context.mounted) Navigator.pop(context);
      registerError(e.code);
    }
   
  }


  void registerError (String message){
    showDialog(context: context, 
    builder: (context) => AlertDialog(
      title: Text(message),
    )
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  const Text('Lets create a account'),
                    
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
            
                   Input(
                    controller: _confirmPasswordInputController, 
                    hintText: "Confirm your password", 
                    isObscureText: true
                  ),
            
                  const SizedBox(height: 10),
                  
                  Button(onTap: signUp, text: 'Sign up'),
            
                   const SizedBox(height: 10),
            
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Already have a account ?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child:const Text(' Login now', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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



