import 'package:flutter/material.dart';
import 'package:socio/pages/loginPage.dart';

import '../pages/signupPage.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages); }
        else{
          return SignupPage(onTap: togglePages);
        }

      
    }
  }
 
