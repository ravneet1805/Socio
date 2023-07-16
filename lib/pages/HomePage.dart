import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio/auth/auth_service.dart';
import 'package:socio/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatPage.dart';
import 'loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//instance of auth
final FirebaseAuth _auth = FirebaseAuth.instance;

  void SignOut(){
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgcolor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Text(
          "SOCIO",
          style: kappBarLogoStyle,
        ),
        leading: GestureDetector(
          onTap: SignOut ,
            child: Icon(Icons.logout_rounded, color: kPrimarycolor, size: 32)),
      ),
      body: _buildUserList(),

    );
  }

  Widget _buildUserList(){
      return StreamBuilder<QuerySnapshot> (
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('Loading..');
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList()
            ),
        );
        },
        );

  }
  //individual user list
 Widget _buildUserListItem(DocumentSnapshot document){
Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
   if (_auth.currentUser!.email != data['email'] ){
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
         height: 70,
         decoration: BoxDecoration(
           boxShadow: [
             const BoxShadow(
               color: kSecondaryColor,
             ),
             const BoxShadow(
               color: kTileColor,
               spreadRadius: -1.0,
               blurRadius: 1.0,
             ),
           ],

           borderRadius: BorderRadius.circular(15.0),
         ),
         child: Center(
           child: ListTile(
             title: Text(data['email']),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(recieveruserEmail: data['username'], recieverUserID: data['uid'],)));
             },
           ),
         ),
       ),
     );
   }else{
     return Container();
   }
 }
}
