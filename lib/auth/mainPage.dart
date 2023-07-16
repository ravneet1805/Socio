import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socio/pages/loginPage.dart';

import '../pages/HomePage.dart';
import 'loginorRegister.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          print(snapshot);
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
