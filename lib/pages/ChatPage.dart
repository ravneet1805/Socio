import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:socio/chat/chat_service.dart';
import 'package:intl/intl.dart';
import 'package:socio/utils/receiverChatBubble.dart';
import 'package:socio/utils/senderChatBubble.dart';

import '../utils/constants.dart';

class ChatPage extends StatefulWidget {
  final String recieveruserEmail;
  final String recieverUserID;

  const ChatPage(
      {Key? key, required this.recieveruserEmail, required this.recieverUserID})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ScrollController _controller = new ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, _messageController.text);
      print(_messageController);

      //clear controller
      _messageController.clear();

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgcolor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Text(widget.recieveruserEmail),
      ),
      body: Column(
        children: [
          //messages
          Expanded(child: _buildMessageList()),

          //userInput
          _buildMessageInput()
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.recieverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        print('StreamBuilder called');

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Connection state: Waiting');
          return Text('Loading..');
        }

        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });


        return ListView.builder(
          controller: _controller,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );


        // return ListView(
        //   children: snapshot.data!.docs
        //       .map((document) => _buildMessageItem(document))
        //       .toList(),
        // );
      },
    );
  }

// build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
          (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? SenderBubble(message: data['message'])
                : ReceiverBubble(message: data['message']),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 16.0 ),
              child: Text(DateFormat.Hm().format(data['timestamp'].toDate()).toString(),
                style: TextStyle(fontSize: 12,
                color: kHintTextcolor),

              ),
            ),
          ],
        ),
      ),
    );
  }

//build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type Your Message',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  hintStyle: TextStyle(
                    color: kHintTextcolor,
                  ),
                ),
                obscureText: false,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: kPrimarycolor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: IconButton(
                      onPressed: sendMessage,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
