import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(String recieverId, String message) async {
//get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

//create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        timestamp: timestamp,
        message: message);

//construct chat room id
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); //sorting the ids
    String chatRoomId = ids.join(
        "_"); //combine the ids into a single string to use as a chatroomID

    //add new message to database
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //const chat roomId(sorted)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join("_");

    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }


}
