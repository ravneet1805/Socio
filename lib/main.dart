import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio/auth/auth_service.dart';
import 'package:socio/auth/loginorRegister.dart';
import 'package:socio/pages/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socio/auth/mainPage.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(create: (context) => AuthService(),
      child: const MyApp(),

    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: MainPage(),
    );
  }
}



