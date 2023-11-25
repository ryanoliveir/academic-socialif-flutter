import 'package:flutter/material.dart';
import 'package:social_if/screens/login_page.dart';
import 'package:social_if/screens/register_page.dart';



class AuthSwitch extends StatefulWidget {
  const AuthSwitch({super.key});
  

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {

  bool showLoginScreen = true;
  bool showRegisterScreen = true;


  void togglePages(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }


  @override
  Widget build(BuildContext context) {
   if(showLoginScreen){
    return Login(onTap: togglePages);
   }

   return Register(onTap: togglePages);
  }
}