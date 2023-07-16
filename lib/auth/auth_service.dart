import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class AuthService extends ChangeNotifier{
// instance of auth
  final FirebaseAuth _firebase_auth = FirebaseAuth.instance;

// instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign in
Future<UserCredential>signInWithEmailandPassword(
    String email, String password,
    ) async{
  try{
    UserCredential userCredential =
        await _firebase_auth.signInWithEmailAndPassword(
            email: email,
            password: password);

    //user collection
    _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email
    }, SetOptions(merge: true));

    return userCredential;
  }
  on FirebaseAuthException catch (e){
    throw Exception(e.code);
  }
}

//signup new user
  Future<UserCredential>signUpWithEmailandPassword(
      String email, String password, String username
      ) async{
    try{
      UserCredential userCredential =
      await _firebase_auth.createUserWithEmailAndPassword(
          email: email,
          password: password);


      //user collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'password': password,
        'username': username
      });

      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }


//sign user out
Future<void> signOut() async{
  return await FirebaseAuth.instance.signOut();
}

}